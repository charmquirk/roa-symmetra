// attack_update


//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}



// One-time changes
switch(attack) {
    
    case AT_EXTRA_1 :
    // Reloads weapon
    	switch(window) {
    		case 2:
    			if (window_timer == 1) {
    				ammo = max_ammo;
    			}
    	}
    	break;
    	
    case AT_TAUNT :
    	if ammo < max_ammo {
    		set_attack(AT_EXTRA_1);
    	}
    	break;
    	
    case AT_FSPECIAL :
    	switch(window) {
            case 1:
            	
                aim_speed = 0;
                weapon_aim = (90*(1-spr_dir));
				beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets

				
                if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}
                break;
                
            case 2:
            	beam_length = 0; // Reset beam length
            	
            	if (ammo > 0) {	ammo--;	}		// Deplete ammo
            	if ammo <= 0 {	beam_length = 0; }	// Hide beam if theres no ammo
            	
            	beam_list = []; 	// Clear list each tick. Prevents getting duplicates of the same person
            	
            	if special_down && ammo > 0 {		// Aiming Mode. Lets you move the beam.
            		if up_down || down_down {		// Aim up or down
            			if up_down && !down_down{	aim_speed += aim_accel*spr_dir; }
            			if down_down && !up_down {	aim_speed -= aim_accel*spr_dir;	}
            		}
            		else {
            			if aim_speed > 0 || aim_speed < 0 { aim_speed = aim_speed*aim_decel; }	// Decellerate since you aren't aiming
            		}
            		
            		aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);	// Aim speed maxes out
            		weapon_aim += aim_speed;	// Weapon aim is modified by aim speed
                    weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;	// Resets aim if you go past 360
                    weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0
                    weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
                    switch(spr_dir){	// Weapon can't be aimed past your head or behind you
                    	case -1:
                    		weapon_aim = clamp(weapon_aim, 90, 270);
                    		break;
                    	case 1:
                    		if weapon_aim > 90 && weapon_aim < 180 {	weapon_aim = 90;	}
                    		if weapon_aim < 270 && weapon_aim > 180 {	weapon_aim = 270;	}
                    		break;
                    }
                    weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim));
					weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim));
				
                    beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim));
                    beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim));
                    // var beam_objects = 3; // number of objects to scan.
                    
                    with oPlayer {				// Scanning players
						if (player != other.player && get_player_team(player) != get_player_team(other.player)) {	// If not me and not on my team
							
							var b_dist = distance_to_point(other.weapon_x, other.weapon_y);		// Document enemy distance from weapon
							
							if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) {
								
								if array_find_index(other.beam_list, b_dist) == -1 {	// If not in the list
									array_push(other.beam_list, b_dist);		// Add to the list of people the beam can hit
								}
							}
						}
            		}
            		if array_length(beam_list) > 0 {	// If there are eligible targets
            			for (i = 0; i < array_length(beam_list); i++;) {	// Descend through list of eligible targets
            				array_sort(beam_list, true);	// Sort list by distance
            				// print_debug("sorted");
            			}
            			with oPlayer {
            				if player != other.player && get_player_team(player) != get_player_team(other.player) {
            				if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, hurtboxID, false, false) {
            				 	if distance_to_point(other.weapon_x, other.weapon_y) == other.beam_list[0] {
            						other.beam_target = id;
            					}
            				}
            				}
            			}
            			
            		}
            		else {
            			beam_length = beam_preview_range;	// If no one in range, set beam length to preview
            		}
            		
            		if beam_target != noone {
            			with beam_target {
            			 		if !collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) || (invincible == true || state == PS_AIR_DODGE || state == PS_SPAWN || state == PS_DEAD || state == PS_RESPAWN || state == PS_ROLL_BACKWARD || state == PS_ROLL_FORWARD || state == PS_WALL_TECH) { //If target should be unable to hit
            						other.beam_target = noone;
            						other.beam_chip = 0;
            			 		}
            			 		else {
            			 			if (other.charge < other.charge_max) {		// If not at max charge
            							other.charge += min(other.charge_max - other.charge, 1);	// Charge beam
            							other.charge = clamp(other.charge, 0, other.charge_max);
        							}
            			 			other.beam_chip++;
            			 			
            			 			other.beam_length = distance_to_point(other.weapon_x, other.weapon_y);
    							}
            			}
            			if beam_chip >= beam_chip_threshold {
            			 	// spawn_hit_fx(beam_target.x, beam_target.y - beam_target.char_height/2, cfx_beam_fire);
            			 	take_damage(beam_target.player, player, 1);
            			 	beam_chip = 0;
            			}
            			
            		}
            		else {
            			charge -= charge_decay;
            			beam_chip = 0;
            			beam_length = beam_preview_range;
            		}
            		
            		// if beam_target == noone {	beam_length = beam_preview_range;	}	// overwrite and set to preview
            		beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
					beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
            		
            	}
                else {
                	window = 3;
                	window_timer = 0;
                }
                // Auto-lock charges
                if (charge < charge_2) { beam_chip_threshold = beam_chip_1; }
				if (charge >= charge_2 && charge < charge_3) { beam_chip_threshold = beam_chip_2; }
				if (charge >= charge_3 ) { beam_chip_threshold = beam_chip_3; }
					
                
                break;
            case 3:
            	beam_target = noone;
                aim_speed = 0;
                weapon_aim = (90*(1-spr_dir));
				beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
                beam_list = [];
                break;
        }
        break;

    case AT_NSPECIAL :
        switch(window) {
        	case 1:
        		orb_out = 0;
        		if (ammo < miniorb_cost) {
        			set_attack(AT_EXTRA_1);
                }
                break;
            case 2:
            	if window_timer == 1 {
            		// sound_play(sound_get("orb charging 1"));
            	}
            	
                // Shooting without aiming by releasing the button early.
            	if (!special_down) {
            		// Uncharged
                    if (state_timer < 16) {
                        set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 3);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99);
                        move_cooldown[AT_NSPECIAL] = 2;
                        orb_out = 1;
                        window = 3;  
                        window_timer = 0;
                    }
                    // Charged
                    else {
                    	set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 3);
                        move_cooldown[AT_NSPECIAL] = 12;
                        orb_out = 2;
                        window = 3;  
                        window_timer = 0;
            		}	
            	}
                else {
                	//Cancels attack into reload
                	if (state_timer < 16 && ammo < orb_cost) {
                		set_attack(AT_EXTRA_1)
                	}
                	if state_timer > 16 {
                		if left_down { spr_dir =-1;}
            			if right_down { spr_dir =1;}
                	}
                    if (state_timer > 120) {
                    	// Charged
                    	set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 3);
                        move_cooldown[AT_NSPECIAL] = 12;
                        orb_out = 2;
                        window = 3;  
                        window_timer = 0;
                    }
                }
                break;
            case 3:
            	sound_stop(sound_get("orb charging 1"));
            	if (window_timer == 1) {
            		if (miniorb_cost > ammo && orb_out == 2 || orb_cost > ammo && orb_out == 2) {
            			set_attack(AT_EXTRA_1);
            		}
            		else {
            			// Ammo cost per orb type
            			if (orb_out == 1) {
            				ammo -= miniorb_cost;
            			}
            			if (orb_out == 2) {
            				ammo -= orb_cost;
            			}
            		}
            	}
            	break;
        }
        break;
    


    case AT_USPECIAL:
        switch(window) {
            case 1:
            	// If teleporters already exist
            	if instance_exists(teleporter_entrance) {
            		teleporter_entrance.state = 1;
            	}
            	if instance_exists(teleporter_exit) {
            		teleporter_exit.state = 1;
            	}
            	break;
            case 2:
            	// Skip to window 3 if not pressing special
                if (!special_down) {
                		if (state_timer > 20) {
                        	window = 3;
                        	window_timer = 0;		
                        }
                        else {
                        	// Destroy if not held down long enough
                        	// instance_destroy(teleporter_entrance);
                        	// instance_destroy(teleporter_exit);
                        	// attack_end();
                        }
                     //   if instance_exists(teleporter_entrance) && instance_exists(teleporter_exit) {
                    	// 	teleporter_entrance.state = 1;
                     //   	teleporter_exit.state = 1;
                     //   	window = 3;
                     //   	window_timer = 0;
                    	// }
                }
                else {
                	// If the previews don't exist, create the previews
                    if (tp_timer <= 0 && window_timer == 1) {
                    	
                    	if !instance_exists(teleporter_entrance) {
                    		teleporter_entrance = instance_create(x, y-32,"obj_article2");
                        	teleporter_entrance.type = "entrance";
                        	array_insert(teleporters, 0, instance_find(teleporter_entrance, 1));
                    	}
                        if !instance_exists(teleporter_exit) {
                        	teleporter_exit = instance_create(x, y-32, "obj_article2");
                        	teleporter_exit.hsp = 16*spr_dir;
                        	teleporter_exit.type = "exit";
                        	array_insert(teleporters, 1, instance_find(teleporter_exit, 1));
                        	sound_play(sound_get("preview"));
                        }
                    }
                    else {
                    	// teleporter_exit.hsp = 0;
                    }
                }
                break;
            case 3:
            	if (window_timer == 1) {
            		if tp_timer <= 0 && instance_exists(teleporter_entrance) && instance_exists(teleporter_exit) {
            			teleporter_entrance.state = 0;
                		teleporter_entrance.vsp = 0;
                		teleporter_entrance.hsp = 0;
                		teleporter_exit.state = 0;
                		teleporter_exit.vsp = 0;
                		teleporter_exit.hsp = 0;
                		// sound_play(sound_get("teleporter deployment 2"));
                		tp_timer = tp_rate;
                		
            		}
            		else {
            			if instance_exists(teleporter_entrance) || instance_exists(teleporter_exit) {
            				teleporters[0].state = 1;
            				teleporters[0].state_timer = 0;
            				teleporters[1].state = 1;
            				teleporters[1].state_timer = 0;
            				move_cooldown[AT_USPECIAL] = tp_timer;
            			}
            		}
            	}
        		break;
        }
        break;
    
    case AT_DSPECIAL :
        switch(window) {
        	case 1 :
     //   		if (move_cooldown[AT_DSPECIAL] > 0 || constructs_available <= 0) {
					// attack = AT_DSPECIAL_2;
	    // 		}
	    		construct_direction = 0;
	    		if constructs_available > 0 && window_timer == 1 {
                    sound_play(sound_get("preview"));
			    }
	    		break;
            case 2:
                if (!special_down) {
                    window = 3;
                    window_timer = 0;
                }
                else {
			        
			        // if left_pressed || right_pressed {
			        // 	if left_pressed && !right_pressed { construct_direction = -1; }
			        // 	if right_pressed && !left_pressed { construct_direction = 1; }
			        // }
			        if left_down || right_down || up_down {
			        	if up_down { construct_direction = 2; }
			        	if left_down && !right_down { construct_direction = -1; }
			        	if right_down && !left_down { construct_direction = 1; }
			        }
			        else {
			        	construct_direction = 0;
			        }
		        }
                break;
            case 3:
                if (window_timer == 1) {
                    if (constructs_available > 0) {
                    	if !has_rune("L"){construct = instance_create(x, y, "obj_article_platform");} // if platform
                    	else {construct = instance_create(x, y+48, "obj_article_solid");}
                    	construct.type = "self";
                    	array_push(constructs, construct);
                    	construct.construct_direction = construct_direction;
                    	construct.construct_speed = construct_speed;
                        sound_play(sound_get("shield bloat 1"));
                        constructs_available -= 1;
                        // if construct_direction == 0 || construct_direction == 2 {
                        	construct_timer += construct_rate;	//static or travelling platform cooldown
                        // }
                        // else {
                        // 	construct_timer += construct_rate2; //moving platform cooldown
                        // }
                        move_cooldown[AT_DSPECIAL] = 6;
                    }
                    else {
                    	
                    	// Destroy oldest in array
                    	if array_length(constructs) > 0 {
                    		constructs[0].state = 1;
                    		constructs[0].state_timer = 0;
                    		if constructs_available <= 0 {move_cooldown[AT_DSPECIAL] = construct_timer;}
                    	}
                    	
                    }
                }
                
                break;
		}
		break;
	break;
}

if (attack == AT_JAB && window = 2) {
	// Cancel the window
    if (!attack_down || ammo <= 0) {
        window = 3;
        window_timer = 0;
    }
    // Finds the point on the circle where the tip would be
    //beam_x = beam_range*real(dcos(weapon_aim));
	//beam_y = beam_range*real(dsin(weapon_aim));
	
	
    // Moving horizontally
    if (right_down || left_down) {
    	hsp += (!free) ? ((1+walk_accel)* (1 +(-2*left_down))) : ((air_accel)*(1 +(-2*left_down)));
    	hsp = (!free) ? (clamp(hsp, -walk_speed, walk_speed)) : (clamp(hsp, -air_max_speed, air_max_speed));
    } else {
    	// hsp = (!free) ? (hsp - (walk_accel*(1 +(-2*left_down)))) : (air_accel*(1 +(-2*left_down)));
    	//hsp = (!free) ? (clamp(hsp, -(walk_speed), (walk_speed))) : (clamp(hsp, -air_speed, air_speed));
    	hsp = 0;
    }
    if jump_pressed && !free {
    	clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
    }
    
    // if (vsp > 0) {
    // 	weapon_aim +=  vsp*(spr_dir)/30 : 0;
    // }
    
}

if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL)  { //&& window == 2
	
	if attack == AT_NSPECIAL || attack == AT_FSPECIAL { draw_indicator = false;	}	// Hide indicator while aiming
	
    // Single Jump
    if jump_pressed && !free {
    	clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
    }
	
	// Walking or Falling
    // if (right_down || left_down) {
    // 	hsp += (!free) ? ((1+walk_accel)* (1 +(-2*left_down))) : ((air_accel)*(1 +(-2*left_down)));
    // 	hsp = (!free) ? (clamp(hsp, -walk_speed, walk_speed)) : (clamp(hsp, -air_max_speed, air_max_speed));
    // } else {
    // 	hsp = (!free) ? (hsp*air_friction) : (hsp*ground_friction);
    // }
    
    // Cannot double jump or dash/sprint while aiming. //
}

if attack == AT_USPECIAL {
	if jump_pressed && !free {
    	clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
    }
    
	if (instance_exists(teleporter_exit) && teleporter_exit.state == -1) {
	// Move the exit horizontally
	if (left_down || right_down) {
		teleporter_exit.hsp += teleporter_exit.accel*(1+(-2*left_down));
		teleporter_exit.hsp = clamp(teleporter_exit.hsp, -teleporter_exit.max_hsp, teleporter_exit.max_hsp);
	}
    else {
    	if teleporter_exit.hsp > 0 || teleporter_exit.hsp < 0 {
    			teleporter_exit.hsp = teleporter_exit.hsp*teleporter_exit.accel;		//decellerate
    	}
	}
	//Move the exit vertically
	if (up_down || down_down ) {
		if up_down {
			teleporter_exit.vsp--;
			teleporter_exit.vsp = clamp(teleporter_exit.vsp, -teleporter_exit.max_vsp, teleporter_exit.max_vsp);
		}
		if (down_down) {
			teleporter_exit.vsp++;
			teleporter_exit.vsp = clamp(teleporter_exit.vsp, -teleporter_exit.max_vsp, teleporter_exit.max_vsp);
    	}
	}
    else {
    	if teleporter_exit.vsp > 0 || teleporter_exit.vsp < 0 {
    		teleporter_exit.vsp = teleporter_exit.vsp*teleporter_exit.accel;		//decellerate if not moving
		}
    }
	}
}
