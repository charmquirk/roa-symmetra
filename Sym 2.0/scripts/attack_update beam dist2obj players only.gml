// attack_update


//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

if free && strong_down {
	attack = AT_EXTRA_2;
}
// if joy_pad_idle != true {
// 	weapon_aim = joy_dir;
// }

// One-time changes
switch(attack) {
    
    case AT_EXTRA_1 :
    	switch(window) {
    		case 2:
    			if (window_timer == 1) {	ammo = max_ammo;	}		 // Reloads weapon
    	}
    	weapon_aim = (90*(1-spr_dir));
        orb_h = (90*(1-spr_dir));
        orb_v = 0;
    	break;
    	
  //  case AT_EXTRA_2:
  //  	switch(window) {
  //      	case 1 :
	 //   		break;
  //          case 2:
  //              if (!special_down) {
  //                  window = 3;
  //                  window_timer = 0;
  //              }
  //              break;
  //          case 3:
  //          	if (turret_charges > 0 && window_timer == 1) { 
		// 		    sentry = instance_create(x, y-15, "obj_article3");
		// 		    array_insert(turrets, 0, sentry);
  //                  move_cooldown[AT_DSPECIAL] = 24;
  //                  turret_timer += turret_rate;
  //                  turret_charges--;
  //                      // sound_play(sound_get("preview"));
		// 	    }
  //              break;
		// }
  //  	break;
    	
    case AT_TAUNT:
    	if ammo < max_ammo {	set_attack(AT_EXTRA_1);   	}
    	break;
    	
    case AT_JAB :
        switch(window) {
            case 1:
            	
                aim_speed = 0;
                weapon_aim = (90*(1-spr_dir));
				beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
				// beam_x = x;
				// beam_y = y;
				
                if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}
                break;
                
            case 2:
            	beam_length = 0;
            	
            	// if (ammo > 0) {	ammo--;	}		// Deplete ammo
            	if ammo <= 0 {	beam_length = 0; }	// Hide beam if theres no ammo
            	
            	beam_list = []; 	// Clear list each tick. Prevents getting duplicates of the same person
            	
            	if attack_down && ammo > 0 {		// Aiming Mode. Lets you move the beam.
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
					
     //               beam_length = beam_preview_range;
     //               beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
					// beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
                    
                    beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim));
                    beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim));
                    
					with oPlayer {				// Scanning players
						if (player != other.player && get_player_team(player) != get_player_team(other.player)) {	// If not me and not on my team
							// b_dist = point_distance(x, y - char_height/2, other.weapon_x, other.weapon_y);		// Document enemy distance between weapon and enemy center
							var b_dist = distance_to_point(other.weapon_x, other.weapon_y);		// Document enemy distance from weapon
							// var b_dist_x =  other.x - other.spr_dir*other.arm_offset_x + round((b_dist + other.beam_offset)*dcos(other.weapon_aim));
							// var b_dist_y =  other.y - other.arm_offset_y - round((b_dist + other.beam_offset)*dsin(other.weapon_aim));
							// if collision_line(other.weapon_x, other.weapon_y, other.beam_x, other.beam_y, self, false, false) {	// If I (enemy player) have my hurtbox collide with the beam line.
							// if collision_line(other.weapon_x, other.weapon_y, b_dist_x, b_dist_y, self, false, false) {	// If I (enemy player) have my hurtbox collide with the beam line.
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
            				// if collision_line(other.weapon_x, other.weapon_y, other.beam_x, other.beam_y, hurtboxID, false, false) {
            				 	if distance_to_point(other.weapon_x, other.weapon_y) == other.beam_list[0] {
            						other.beam_target = id;
            					}
            				// }
            				}
            			}
            		}
            		else {
            			beam_length = beam_preview_range;	// If no one in range, set beam length to preview
            		}
            		
            		
            		if beam_target != noone {
            			with beam_target {
            				if object_index = oPlayer {
            			 		if !collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) || invincible == true || state == PS_AIR_DODGE || state == PS_SPAWN || state == PS_DEAD || state == PS_RESPAWN || state == PS_ROLL_BACKWARD || state == PS_ROLL_FORWARD || state == PS_WALL_TECH { //If target should be unable to hit
            						other.beam_target = noone;
            						other.beam_chip = 0;
            			 		}
            			 		else {
            			 			if (other.charge < other.charge_max) {		// If not at max charge
            							other.charge += min(other.charge_max - other.charge, 1);	// Charge beam
            							other.charge = clamp(other.charge, 0, other.charge_max);
        							}
            			 			other.beam_chip++;
            			 			if other.beam_chip >= other.beam_chip_threshold {
            			 				spawn_hit_fx(x, y - char_height/2, other.cfx_beam_fire);
            			 				take_damage(player, other.player, 1);
            			 				other.beam_chip = 0;
            			 			}
    							}
            				}
            				other.beam_length = distance_to_point(other.weapon_x, other.weapon_y);
            			}
            			
            		}
            		else {
            			beam_chip = 0;
            			beam_length = beam_preview_range;
            		}
            		
            	
            				
    						
    				// 		if beam_length > beam_offset {
    				// 			beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
								// beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
								// // beam_x = beam_target.x;		// Finds the point on the circle where the x coordinate of the tip would be
								// // beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
								// // beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
								// // beam_y = beam_target.y - beam_target.char_height/2;		// Finds the point on the circle where the y coordinate of the tip would be
    				// 		}
    				// 		else {
    				// 			// beam_x = x - spr_dir*arm_offset_x + round((beam_length)*dcos(weapon_aim));
    				// 			// beam_y = y - arm_offset_y - round((beam_length)*dsin(weapon_aim));
    				// 			// beam_length = point_distance(x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)), y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)), beam_target.x, beam_target.y - beam_target.char_height/2);
    				// 			// beam_x = x - spr_dir*arm_offset_x + round((beam_offset-beam_length)*dcos(weapon_aim));
    				// 			// beam_y = y - arm_offset_y - round((beam_offset-beam_length)*dsin(weapon_aim));
    				// 		}
    						
    						
    						
    						
            		// 	}
            		// }
            		// else {
            		// 	beam_target = noone;
            		// 	beam_chip = 0;
            		// }
            	
            		
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
        
    case AT_FSPECIAL :
    	switch(window) {
    		case 1:
    			if (barrier_timer > 0) {
    				set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
    			}
    			else {
    				reset_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME);
    			}
    			if up_down || down_down {
                		if up_down {
                			set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_VSPEED, -1);
                			set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 1);
                		}
                		if down_down {
                			set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 0);
                			set_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME, 360);
                			// set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 1);
                		}
                		
                }
                else {
                	reset_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_VSPEED);
                	reset_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED);
                	reset_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME);
                }
    			
    			break;
    		case 3:
                if (window_timer == 1) {
                	if get_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED) == 0 {
                		barrier_timer = 2*barrier_rate;
                	}
                	else {
                		barrier_timer = barrier_rate;
                	}
                    move_cooldown[AT_FSPECIAL] = barrier_timer;
                }
            break;
    	}
    	break;

    case AT_NSPECIAL :
        switch(window) {
        	case 1:
        		if state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR {		//start of the move. dont use window == 1
        			aim_speed = 0;
        			if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}		//Reload
        			reset_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME);
                	reset_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME);
                	
                	// Uncharged
                	set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99);
                	
                	// weapon_aim = abs(180*(1 + floor(weapon_aim/180)) - weapon_aim); //abs(weapon_aim-90*(2*floor(weapon_aim/180))) + 9			abs(180*(floor(weapon_aim/180))-weapon_aim)
        			// if weapon_aim < 180 {	weapon_aim = abs(180 - weapon_aim);	}
        			// if weapon_aim > 180 {	weapon_aim = 180 + abs(180 - weapon_aim);	}
        			// switch(spr_dir) {	// Weapon can't be aimed past your head or behind you
           //         	case -1:
                    		
           //         		break;
           //         	case 1:
           //         		if weapon_aim > 90 && weapon_aim < 180 {	abs(180 - weapon_aim);	}
           //         		if weapon_aim < 270 && weapon_aim > 180 {	180 + abs(180 - weapon_aim);	}
           //         		break;
           //         }
        			
        		}
                break;
            case 2:
            	if (special_down) {
            		// Charged
            		reset_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME);
            		set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
            		
            		if (up_down || down_down) {			// Aiming Mode
            			if up_down && !down_down{
            				aim_speed += aim_accel*spr_dir;
            			}
            			if down_down && !up_down {
            				aim_speed -= aim_accel*spr_dir;
            			}
            		}
            		else {
            			if aim_speed > 0 || aim_speed < 0 { aim_speed = aim_speed*aim_decel; }	// Decelerate since you aren't aiming
            		}
        			weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim));
					weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim));
                    aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);	// Aim speed maxes out
                    weapon_aim += aim_speed;	// Weapon aim is modified by aim speed
                    weapon_aim = (up_down || down_down) ? weapon_aim : round(weapon_aim);
                    weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;	// Resets aim if you go past 360
                    weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0
                    weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
                    switch(spr_dir) {	// Weapon can't be aimed past your head or behind you
                    	case -1:
                    		weapon_aim = clamp(weapon_aim, 90, 270);
                    		break;
                    	case 1:
                    		if weapon_aim > 90 && weapon_aim < 180 {	weapon_aim = 90;	}
                    		if weapon_aim < 270 && weapon_aim > 180 {	weapon_aim = 270;	}
                    		break;
                    }
            		// set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_HSPEED, beam_offset*(spr_dir*dcos(weapon_aim)));
            		// set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_VSPEED, -beam_offset*dsin(weapon_aim));
            		orb_h = orb_speed*dcos(weapon_aim);
            		orb_v = orb_speed*dsin(weapon_aim);
            		// orb_h = round(orb_h);
            		// orb_v = round(orb_v);
            		set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_HSPEED, spr_dir*orb_h);
            		set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_VSPEED, -orb_v);
            		
            		set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_X, spr_dir*beam_offset*dcos(weapon_aim) - arm_offset_x);
            		set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_Y, -beam_offset*dsin(weapon_aim) - arm_offset_y);
            	}
            	else {
            		window = 3;
            		window_timer = 0;
            	}
            	// if (!special_down) {window = 3;	window_timer = 0;}
                if left_pressed { spr_dir = -1; weapon_aim = 180;}
                if right_pressed { spr_dir = 1; weapon_aim = 0;}
                break;
            case 3:
            	sound_stop(sound_get("orb charging 1"));
            	aim_speed = 0;
            	if (window_timer == 1) {
            		if get_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME) == 99 {	//Mini Orb
            			if ammo < miniorb_cost {
            				set_attack(AT_EXTRA_1);
            			}
            			else {
            				ammo -= miniorb_cost;
            			}
            		}
            		else {	// Big Orb
            			if ammo < orb_cost {
            				set_attack(AT_EXTRA_1);
            			}
            			else {
            				ammo -= orb_cost;
            			}
            		}
            	}
            	break;
        }
        break;
        
        case AT_NAIR:
        	set_attack(AT_JAB);
        	break;
        
    case AT_USPECIAL:
        switch(window) {
            case 1:
            	if instance_exists(teleporter_entrance) {	teleporter_entrance.state = 1;	}
            	if instance_exists(teleporter_exit) {	teleporter_exit.state = 1;	}
            	tpx_x = x+32*spr_dir;
				tpx_xv = 0;
				tpx_y = y;
            	break;
            case 2:
            	// if !instance_exists(teleporter_entrance) && !instance_exists(teleporter_exit) {
            	// 	window = 3;
             //       window_timer = 0;
            	// }
            	// Skip to window 3 if not pressing special
                if (!special_down) {
                	if (state_timer > 20) {
                		window = 3;
                		window_timer = 0;
                	}
                }
                else {
                	// If the previews don't exist, create the previews
                    if (tp_timer <= 0 && window_timer == 1) {
                    	if !instance_exists(teleporter_entrance) {
                    		teleporter_entrance = instance_create(x,y,"obj_article2");
                        	teleporter_entrance.type = "entrance";
                        	teleporter_entrance.state = -1;
                        	array_insert(teleporters, 0, instance_find(teleporter_entrance, 1));
                    	}
                        if !instance_exists(teleporter_exit) {
                        	teleporter_exit = instance_create(x+64*spr_dir,y,"obj_article2");
                        	teleporter_exit.type = "exit";
                        	teleporter_exit.state = -1;
                        	array_insert(teleporters, 1, instance_find(teleporter_exit, 1));
                        	sound_play(sound_get("preview"));
                        }
                    }
                }
                break;
            case 3:
            	if (tp_timer <= 0 && window_timer == 1 && instance_exists(teleporter_entrance) && instance_exists(teleporter_exit) ) {
                	teleporter_entrance.state = 0;
                	teleporter_exit.state = 0;
                	sound_play(sound_get("teleporter deployment 2"));
                	tp_timer = tp_rate;
                	move_cooldown[AT_USPECIAL] = tp_timer;
            	}
        		break;
        }
        break;
    
    case AT_DSPECIAL :
        switch(window) {
        	case 1 :
        		break;
            case 2:
                if (!special_down) {
                    window = 3;
                    window_timer = 0;
                }
                invisible = true;
                break;
            case 3:
            	if (turret_charges > 0 && window_timer == 1) { 
            		if free { sentry = instance_create(x, y-char_height/2, "obj_article3"); }
            		else { sentry = instance_create(x, y-18, "obj_article3"); sentry.can_be_grounded = true;}
				    
				    array_push(turrets, sentry);
                    // move_cooldown[AT_DSPECIAL] = 24;
                    turret_timer += turret_rate;
                    turret_charges--;
                    sound_play(sound_get("preview"));
                    move_cooldown[AT_DSPECIAL] = 12;
			    }
                break;
		}
		break;
}

if (attack == AT_NSPECIAL || attack == AT_JAB) && window == 2 {
	
	draw_indicator = false;		// Hide indicator while aiming
	
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
	if (instance_exists(teleporter_exit)) {
		// Move the exit horizontally
		if (left_down || right_down) {
			tpx_xv += teleporter_exit.accel*(1+(-2*left_down));
			tpx_xv = clamp(tpx_xv, -teleporter_exit.max_hsp, teleporter_exit.max_hsp);
			tpx_x += tpx_xv; 
			teleporter_exit.x = tpx_x;
		}
		else {
    		if tpx_xv > 0 || tpx_xv < 0 { tpx_xv = tpx_xv*teleporter_exit.accel; }		//decellerate
		}
		if tpx_x > x { spr_dir = 1; }
		else { spr_dir = -1; }
		
		// Move the exit vertically
		if (up_pressed || down_pressed ) {
			if up_pressed {
			
				teleporter_exit.can_be_grounded = true;
				
				if teleporter_exit.free != true {
					teleporter_exit.vsp = -256;
				}
				
				// if instance_place(x,y,"par_block") 
			}
			if (down_pressed) {
				teleporter_exit.vsp++;
				teleporter_exit.vsp = clamp(teleporter_exit.vsp, -teleporter_exit.max_vsp, teleporter_exit.max_vsp);
				teleporter_exit.vsp = 16;
				teleporter_exit.can_be_grounded = false;
    		}
		}
    	else {
    		teleporter_exit.vsp = 64;		//gravity
		}
		if jump_pressed && !free {
    		clear_button_buffer(PC_JUMP_PRESSED);
			vsp = -jump_speed;
			sound_play(asset_get("sfx_jumpground"));
    	}
	}
}

#define scan_objects(index, obj)
// Used in a for loop's with statement to scan multiple objects
// with (scan_objects(index, obj1, obj_2, obj_3))

return argument[argument[0] + 1];
