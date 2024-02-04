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
    	
    case AT_TAUNT:
    	if ammo < max_ammo {
    		set_attack(AT_EXTRA_1);
    	}
    	break;
    	
    case AT_JAB :
        switch(window) {
            case 1:
                // Resets the variables and aim
                weapon_aim = (90*(1-spr_dir));
                beam_x = x + round(beam_preview_range*real(dcos(weapon_aim)));
				beam_y = y - 32 - round(beam_preview_range*real(dsin(weapon_aim)));
                aim_speed = 0;
                o_dist = 0;
                o_angle = 0;
                
                if (ammo <= 0) {
        
                	set_attack(AT_EXTRA_1);
                	// attack_end();
                }
                break;
                
            case 2:
            		// if (ammo > 0) {
            		// 	ammo--;		// Deplete ammo
            		// }
            		if beam_target == noone {
            			// Aiming Reticle before lock on
            			// if pressing up or down, aim speed will accelerate according to which button is pressed and the sprite direction. If nothing is pressed, aim speed decelleratess.
                    	aim_speed = (up_down || down_down) ? aim_speed + (aim_accel*(1 + (-2*down_down))*spr_dir) : aim_speed*aim_decel;
                    	// Clamp aimspeed to stop decelerating at 0
                    	// clamp(aim_speed, (aim_speed-aim_speed)/2, (aim_speed+aim_speed)/2);
                    	// Aim speed increases exponentially if firing
                    	// aim_speed = (up_down || down_down) ? aim_speed * max(abs(aim_speed), 1) : aim_speed;
                    	// Aim speed maxes out
                		aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);
                    	// Weapon aim is modified by aim speed
                		weapon_aim += aim_speed;
                		
                		// Resets aim if you go past 360 or below 0
                		weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;
                		weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;
                		weapon_aim = clamp(weapon_aim, 0, 360);
                		
                    	// Weapon can't be aimed past your head or behind you
                    	switch(spr_dir){
                    		case -1:
                    			weapon_aim = clamp(weapon_aim, 90, 270);
                    			break;
                    		case 1:
                    			if weapon_aim > 90 && weapon_aim < 180 {
                    				weapon_aim = 90;
                    			}
                    			if weapon_aim < 270 && weapon_aim > 180 {
                    				weapon_aim = 270;
                    			}
                    			break;
                    	}
            			
            			// Finds the point on the circle where the tip would be
    					beam_x = x + round(beam_preview_range*real(dcos(weapon_aim)));
						beam_y = y - 32 - round(beam_preview_range*real(dsin(weapon_aim)));
						beam_length = beam_preview_range;
            			
            			with oPlayer {
            				if (player != other.player && get_player_team(player) != get_player_team(other.player)) {
            					var o_dist = point_distance(x, y-char_height/2, other.x, other.y-32);		// Distance between target and player
            					var o_angle = point_direction(other.x, other.y-32, x, y-char_height/2);		// View angle of player
            					if (o_dist <= other.beam_range && o_angle >= other.weapon_aim - other.angle_allowance && o_angle <= other.weapon_aim + other.angle_allowance) { // If the opponent is within range, in front of you, and the weapon is aimed at them, target them.
            					 //&& o_angle >= other.weapon_aim - other.angle_allowance && o_angle <= other.weapon_aim + other.angle_allowance
            					//  && o_angle == other.weapon_aim
            					// && o_angle> -90+90*(1-spr_dir) && o_angle < 90+90*(1-spr_dir)
            					// && o_angle == other.weapon_aim
            					// if (o_dist <= other.beam_range && other.spr_dir = -1 && x <= other.x || o_dist <= other.beam_range && other.spr_dir = 1 && x >= other.x) {
            						if instance_place(x,y,pHurtBox) {
            							
            						}
            						
            						// If x is greater than or equal to in front of player
            						// if player is facing left, if the opponent is 
            						
            						other.beam_x = x;
            						other.beam_y = y - char_height/2;
            						other.beam_length = o_dist;
            						other.weapon_aim = o_angle;
            					}
            				}
            			}

            			
            		}
            		else {
            				if (weapon_aim > 90 && weapon_aim < 270){
	            				spr_dir = -1;
            				}
            				else {
            					spr_dir = 1;
            				}
            			
            			if (!up_down && !down_down) {	// Maintain aim if angle is not manually changed
            				weapon_aim = point_direction(x, y-32, beam_target.x, beam_target.y-beam_target.char_height/2);
            				beam_length = point_distance(beam_target.x, beam_target.y-char_height/2, x, y-32);
            				beam_x = beam_target.x;
                			beam_y = beam_target.y - beam_target.char_height/2;
            			}
            			else {
            				beam_target = noone;	// Disconnects if you attempt to aim past target
            			}
            		}
            		
            		// weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;
            			// if beam_target == noone {
            			// 	beam_x = x + (spr_dir*(beam_range/3*2));
            			// 	beam_y = y - char_height/2;
            			// }
            			// beam_x = x + (spr_dir*(beam_range/4*3));
            			// beam_y = y - char_height/2;
            			// weapon_aim = (90*(1-spr_dir));
            			// beam_target = noone;
            			// forces disconnect if out of range
            			
            			
            			// if (attack != AT_JAB || attack == AT_JAB && !attack_down || beam_target == noone || ) {beam_timer--;}
            	
            			// with oPlayer {
            			// 	if (player != other.player && get_player_team(player) != get_player_team(other.player)) {
            			// 		var o_dist = point_distance(x, y - char_height/2, other.x, other.y-31);
            			// 		var o_angle = point_direction(other.x, other.y-31, x, y - char_height/2);
            			// 		// Attaches beam if no one is targeted and you are in range OR you are the target, you are within extended range, and the lock on timer hasn't ended yet.
            			// 		if (other.beam_target == noone && o_dist <= other.beam_range || other.beam_target == id && other.beam_timer > 0 && o_dist <= 2*other.beam_range ) {
            								 
            			// 			// other.beam_target = id;
            			// 			other.beam_x = x;
            			// 			other.beam_y = y - char_height/2;
            			// 			other.weapon_aim = o_angle;
            			// 			if (o_dist <= other.beam_range) {
            			// 				other.beam_timer = other.beam_lock_time;
            			// 			}
            			// 		}
            			// 		else {
            			// 			if (other.beam_timer > 0) {
            			// 				other.beam_timer--;
            			// 			}
            			// 		}
            			// 	}
            			// }
            				// hit_player_obj = beam_target;
            				// beam_x = hit_player_obj.x;
            				// beam_y = hit_player_obj.y - hit_player_obj.char_height/2;
            			
            			// if (weapon_aim > 270 || weapon_aim < 90) {
            			// 	spr_dir = 1;
            			// } 
            			// if (weapon_aim > 90 && weapon_aim < 270){
            			// 	spr_dir = -1;
            			// }
            		// }
            		// else {
            		// 	beam_x = x + (spr_dir*(beam_range/4*3));
            		// 	beam_y = y - char_height/2;
            			// weapon_aim = (90*(1-spr_dir));
            		// }
            		
            		
            		
            					// else {
            						// other.beam_target = noone;
            						// other.beam_x = x + (other.spr_dir*(other.beam_range/3*2));
            						// other.beam_y = y - other.char_height/2;
            					// }
            		
            		// Auto-lock charges
            		//Level 1
					if (charge < c_level2) {
            			set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 10);
                        set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 10);
                        set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 1);
            		}
            		
                    // Move to level 2
                    if (charge >= c_level2 && charge < c_level3) {
                        set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 6);
                        set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 6);
                        set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 1);
                    }
                    // Move to level 3
                    if (charge >= c_level3 ) {
                        set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 3);
                        set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 3);
                        set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 1);
                    }
     //       		// Level 1
					// if (charge < c_level2) {
     //       			set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 8);
     //                   set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 9);
     //                   set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 1);
     //                   set_hitbox_value(AT_JAB, 1, HG_WIDTH, 13);
     //                   set_hitbox_value(AT_JAB, 1, HG_HEIGHT, 13);
     //       		}
            		
     //               // Move to level 2
     //               if (charge >= c_level2 && charge < c_level3) {
     //                   set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 5);
     //                   set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 6);
     //                   set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 1);
     //                   set_hitbox_value(AT_JAB, 1, HG_WIDTH, 9);
     //                   set_hitbox_value(AT_JAB, 1, HG_HEIGHT, 9);
     //               }
     //               // Move to level 3
     //               if (charge >= c_level3 ) {
     //                   set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 3);
     //                   set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 4);
     //                   set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 2);
     //                   set_hitbox_value(AT_JAB, 1, HG_WIDTH, 3);
     //                   set_hitbox_value(AT_JAB, 1, HG_HEIGHT, 3);
     //               }
     
     
     
    			
     
     
     
     
     
            		// // Aiming
            		// // if pressing up or down, aim speed will accelerate according to which button is pressed and the sprite direction. If nothing is pressed, aim speed is 0.
              //      aim_speed = (up_down || down_down) ? aim_speed + (aim_accel*(1 + (-2*down_down))*spr_dir) : 0;
              //      // Aim speed increases exponentially
              //      aim_speed = aim_speed * max(abs(aim_speed), 1);
                    
              //      // aim_speed = (vsp > 0) ? (aim_speed + vsp*(spr_dir)) : aim_speed;
                    
              //      // Aim speed maxes out
              //      aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);
              //      // Weapon aim is modified by aim speed if up or down is pressed
              //      weapon_aim += (up_down || down_down) ? aim_speed : 0;
              //      // Weapon can't be aimed past your head or behind you
              //      weapon_aim = clamp(weapon_aim, -90, 90);
                    
    
                    
                break;
            case 3:
            	beam_target = noone;
                aim_speed = 0;
                // weapon_aim = (90*(1-spr_dir));
                // weapon_aim = 0;
                // beam_x = 0;
                // beam_y = 0;
                break;
        }
        break;
        
    case AT_FSPECIAL :
    	switch(window) {
    		case 1:
    			if (barrier_timer > 0) {
    				set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
    			}
    			else {
    				reset_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME);
    			}
    			if solids_available > 0 {
                    	with pHitBox {
                    		if attack == AT_FSPECIAL && other.id == player_id && instance_exists(barrier) {
                    			other.solid_v = instance_create(x,y,"obj_article_solid");
                    			other.solid_v.type = "vertical";
                    			instance_destroy(self);
                    			exit;
                    		}
                    		
                    	}
                    	if instance_exists(solid_v) {
       //             		solid_v.sprite_index = sprite_get("solid_vertical");
							// solid_v.mask_index = sprite_get("solid_vertical");
							solid_v.hsp = solid_speed*spr_dir;
                        	solid_timer += solid_rate;
                        	solids_available -= 1;
                    	}
                    }
    			
    			break;
    		case 3:
                if (window_timer == 1) {
                    barrier_timer = barrier_rate;
                    
                    // Prevents consuming ammo from nspecial  && move_cooldown[AT_FSPECIAL] > 0
                    // move_cooldown[AT_NSPECIAL] = 3;
                    
                    // move_cooldown[AT_FSPECIAL] = barrier_timer;
                }
            break;
    	}

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
            		sound_play(sound_get("orb charging 1"));
            	}
            	
                // Shooting without aiming by releasing the button early.
            	if (!special_down) {
            		// Uncharged
                    if (state_timer < 16) {
                        set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 3);
                        move_cooldown[AT_NSPECIAL] = 2;
                        orb_out = 2;
                        window = 3;  
                        window_timer = 0;
                    }
                    // Charged
                    else {
                        set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 3);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99);
                        move_cooldown[AT_NSPECIAL] = 12;
                        orb_out = 1;
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
                        set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 3);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99);
                        move_cooldown[AT_NSPECIAL] = 12;
                        orb_out = 1;
                        window = 3;  
                        window_timer = 0;
                    }
                }
                break;
            case 3:
            	sound_stop(sound_get("orb charging 1"));
            	if (window_timer == 1) {
            		if (orb_cost > ammo && orb_out == 1 || miniorb_cost > ammo && orb_out == 2) {
            			set_attack(AT_EXTRA_1);
            		}
            		else {
            			// Ammo cost per orb type
            			if (orb_out == 1) {
            				ammo -= orb_cost;
            			}
            			if (orb_out == 2) {
            				ammo -= miniorb_cost;
            			}
            		}
            	}
            	break;
            
        }
        break;
    


    case AT_USPECIAL:
        switch(window) {
            case 1:
            	// Destroy previous teleporters
            	// if (instance_exists(teleporter_entrance) || instance_exists(teleporter_entrance)) {
            	// 	instance_destroy(teleporter_entrance);
            	// 	instance_destroy(teleporter_exit);
            	// }
            	// if (teleporters[0] != noone) {
            	// 	//array_find_index(teleporters, 0) != noone
            	// 	teleporter_entrance.state = 1;
            	// 	teleporter_exit.state = 1;
            	// }
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
                			//&& state != PS_HITSTUN && state != PS_HITSTUN_LAND
                			//&& state != PS_ATTACK_AIR  state != PS_ATTACK_AIR 
                        	window = 3;
                        	window_timer = 0;		
                        }
                        else {
                        	// Destroy if not held down long enough
                        	instance_destroy(teleporter_entrance_preview);
                        	instance_destroy(teleporter_exit_preview);
                        	attack_end();
                        }
                        
                }
                else {
                	// If the previews don't exist, create the previews
                    	if (!instance_exists(teleporter_entrance_preview) && tp_timer <= 0 && window_timer == 1) {
                        	// if has_rune("G") {
                        		teleporter_entrance_preview = instance_create(x,y,"obj_article1");
                        		teleporter_entrance_preview.type = "teleporter_entrance_preview";
                        	
                        		teleporter_exit_preview = instance_create(x,y,"obj_article1");
                        		teleporter_exit_preview.type = "teleporter_exit_preview";
                        		// teleporter_exit_preview.hsp = 16*spr_dir;
                        	sound_play(sound_get("preview"));
                        	
                        	// }
                        	
                    	}
                    }
                break;
            case 3:
            	if (window_timer == 1 && instance_exists(teleporter_entrance_preview) && tp_timer <= 0) {
                	instance_destroy(teleporter_entrance_preview);
                	
                	teleporter_entrance = instance_create(x,y,"obj_article2");
                	teleporter_entrance.type = "entrance";
                	array_insert(teleporters, 0, instance_find(teleporter_entrance, 1));
                	
                	teleporter_exit = instance_create(teleporter_exit_preview.x, teleporter_exit_preview.y,"obj_article2");
                	teleporter_exit.type = "exit";
                	
                	array_insert(teleporters, 1, teleporter_exit);
                	instance_destroy(teleporter_exit_preview);
                	
                	sound_play(sound_get("teleporter deployment 2"));
                	tp_timer = tp_rate;
                	move_cooldown[AT_USPECIAL] = 15;
            	}
        		break;
        }
        break;
    
    case AT_DSPECIAL :
        switch(window) {
        	case 1 :
     //   		if (move_cooldown[AT_DSPECIAL] > 0 || solids_available <= 0) {
					// attack = AT_DSPECIAL_2;
	    // 		}
	    		break;
            case 2:
                if (!special_down) {
                    window = 3;
                    window_timer = 0;
                }
                else {
			        if (!instance_exists(solid_preview) && solids_available > 0 && window_timer == 1) { 
				        solid_preview = instance_create(x - 64, y, "obj_article1");
        		        solid_preview.type = "solid_preview";
                        sound_play(sound_get("preview"));
			        }
		        }
                break;
            case 3:
                if (window_timer == 1) {
                    if (solids_available > 0) {
                        instance_destroy(solid_preview);
                        solid_h = instance_create(x - 64, y-96*(up_down), "obj_article_solid");
                        solid_h.type = "horizontal";
                        solid_h.hsp = solid_speed*right_down -solid_speed*left_down;
                        sound_play(sound_get("shield bloat 1"));
                        array_insert(solids, 0, solid_h);
                        move_cooldown[AT_DSPECIAL] = 24;
                        solid_timer += solid_rate;
                        solids_available -= 1;
                    }
                    else {
                    	// Destroy oldest in array
                    	if array_length(solids) > 0 {
                    		solids[array_length(solids)-1].state = 1;
                    		solids[array_length(solids)-1].state_timer = 0;
                    		solids = array_slice(solids, 0, array_length(solids)-1);
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

if (attack == AT_NSPECIAL && jump_pressed && !free) {
	clear_button_buffer(PC_JUMP_PRESSED);
	vsp = -jump_speed;
	sound_play(asset_get("sfx_jumpground"));
}

if attack == AT_USPECIAL {
	if (instance_exists(teleporter_exit_preview)) {
	// Move the exit horizontally
	if (left_down || right_down) {
		teleporter_exit_preview.hsp += teleporter_exit_preview.accel*(1+(-2*left_down));
		teleporter_exit_preview.hsp = clamp(teleporter_exit_preview.hsp, -teleporter_exit_preview.max_hsp, teleporter_exit_preview.max_hsp);
	}
    else {
    	teleporter_exit_preview.hsp = 0;
	}
	//Move the exit vertically
	if (up_down ) {
		teleporter_exit_preview.vsp--;
		teleporter_exit_preview.vsp = clamp(teleporter_exit_preview.vsp, -teleporter_exit_preview.max_vsp, teleporter_exit_preview.max_vsp)
		teleporter_exit_preview.can_be_grounded = true;
	}
    else {
    	teleporter_exit_preview.vsp = 8;
    	
    	if (down_down) {
			teleporter_exit_preview.can_be_grounded = false;
			//teleporter_exit_preview.fall_through;
		}
	}
	}
}
