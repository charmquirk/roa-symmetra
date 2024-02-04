// attack_update


//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

if free && strong_down {
	attack = AT_EXTRA_2;
}
// if gamepad_is_connected(player) {
	// weapon_aim = joy_dir;
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
                beam_length = beam_preview_range;
                beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));
				beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));
				// spawn_hit_fx(x - spr_dir*arm_offset_x + round(beam_offset*dcos(weapon_aim)), y - arm_offset_y - round(beam_offset*dsin(weapon_aim)), cfx_beam_fire);
                
                // o_dist = 0;
                // o_angle = 0;
                if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}
                break;
                
            case 2:
            	spawn_hit_fx(beam_x, beam_y, cfx_beam_fire);
            	if (ammo > 0) {	ammo--;	}		// Deplete ammo
            	if ammo <= 0 {	beam_length = 0; }	// Hide beam if theres no ammo
            	if attack_down && ammo > 0 {
            	if (up_down || down_down) {			// Aiming Mode. Lets you move the beam.
            		if up_down && !down_down{
            			aim_speed += aim_accel*spr_dir;
            		}
            		if down_down && !up_down {
            			aim_speed -= aim_accel*spr_dir;
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
                    		if weapon_aim > 90 && weapon_aim < 180 {
                    			weapon_aim = 90;
                    		}
                    		if weapon_aim < 270 && weapon_aim > 180 {
                    			weapon_aim = 270;
                    		}
                    		break;
                    }
                    beam_length = beam_preview_range;		// Beam length is at preiview range when not targeting anyone
                    beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
					beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
				}
            	else {		// Targeting mode. Lets you lock on.
            		
            		if aim_speed > 0 || aim_speed < 0 { aim_speed = aim_speed*aim_decel; }	// Decellerate since you aren't aiming
            		weapon_aim += aim_speed;	// Weapon aim is modified by aim speed
                    weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;	// Resets aim if you go past 360
                    weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0
                    weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
                    switch(spr_dir){	// Weapon can't be aimed past your head or behind you
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
                    
                    if beam_target == noone {		// If no target
                    	beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
						beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
						
						with oPlayer {				// Scanning players
							if (player != other.player && get_player_team(player) != get_player_team(other.player)) {
								if collision_line(other.x - other.spr_dir*other.arm_offset_x + round(other.beam_offset*dcos(other.weapon_aim)), other.y - other.arm_offset_y - round(other.beam_offset*dsin(other.weapon_aim)), other.beam_x, other.beam_y, hurtboxID, false, false) {	// If I (enemy player) have my hurtbox collide with the beam line.
									if array_find_index(other.beam_list, id) == -1 {
										array_push(other.beam_list, id);		// Add me to the list of people the beam can hit
										other.y -= 16;
									}
								}
							}
            			}
            			if array_length(beam_list) > 0 {	// If there are eligible targets
            				for (i = 0; i < array_length(beam_list); i++;) {	// Descend through list of eligible targets
            					if array_length(beam_list) == 1 {	// One eligbible target
            						beam_target = beam_list[i];
            					}
            					if array_length(beam_list) > 1  {	// Multiple eligible targets
            				
            					}
            				}
            			}
            		}
            		else {					// If you have a target
            			beam_list = [];		// Clear beam list
            			aim_speed = 0;		// Clear aim speed
            			
            			if beam_target.invincible == true || beam_target.state == PS_AIR_DODGE || beam_target.state == PS_SPAWN || beam_target.state == PS_DEAD || beam_target.state == PS_RESPAWN || beam_target.state == PS_ROLL_BACKWARD || beam_target.state == PS_ROLL_FORWARD || beam_target.state == PS_WALL_TECH { //If target should be unable to hit
            				beam_target = noone;
            			}
            			else {	// If beam target is not invincible
            			
            				if (weapon_aim > 90 && weapon_aim < 270) {
            					spr_dir = -1;
            				}
            				else {
            					spr_dir = 1;
            				}
            				
            				// weapon_aim = point_direction(x - spr_dir*arm_offset_x + round(beam_length*dcos(weapon_aim)), y - arm_offset_y - round(beam_length*dsin(weapon_aim)), beam_target.x, beam_target.y-beam_target.char_height/2);
            				//find way to remove weapon aim angles from the above to stop rewriting itself
            				// weapon_aim = point_direction(x - spr_dir*arm_offset_x + beam_offset*dcos(weapon_aim), y - arm_offset_y - beam_offset*dsin(weapon_aim), beam_target.x, beam_target.y-beam_target.char_height/2);
            				weapon_aim = point_direction(x, y - arm_offset_y, beam_target.x, beam_target.y-beam_target.char_height/2);
            				// beam_length = point_distance(beam_target.x, beam_target.y - beam_target.char_height/2, x - spr_dir*arm_offset_x + round((beam_length + beam_offset)*dcos(weapon_aim)), y - arm_offset_y - round((beam_length + beam_offset)*dsin(weapon_aim)));
            				beam_length = point_distance(beam_target.x, beam_target.y - beam_target.char_height/2, x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)), y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)));
            			
            				if (beam_length <= beam_range || beam_timer > 0 && beam_length <= beam_max_range) {
            				
            					beam_x = beam_target.x;
            					beam_y = beam_target.y - beam_target.char_height/2;
            				
            					if beam_length <= beam_range {		// If the target is within range
            					beam_timer = beam_lock_time;	// Fill beam lock on timer
            					}
            					if (charge < c_level3max) {		// If not at max charge
            						charge += min(c_level3max - charge, 1);	// Charge beam
            						clamp(charge, 0, c_level3max);
        						}
            				}
            			}
            		}
            	}
            	}
            	else {
            		window = 3;
        			window_timer = 0;
            	}
            	
            	
            	
            	
            	
            	
            	
            	
            	
				
            	
            	// Auto-lock charges
				// if (charge < c_level2) { charge_length = c_level1_length; }
				// if (charge >= c_level2 && charge < c_level3) { charge_length = c_level2_length; }
				// if (charge >= c_level3 ) { charge_length = c_level3_length; }
				// set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, charge_length);
				// set_hitbox_value(AT_JAB, 1, HG_LIFETIME, charge_length);
					
                
                break;
            case 3:
            	beam_target = noone;
                aim_speed = 0;
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
        		aim_speed = 0;
        		if window_timer == 1 {
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
                break;
            case 3:
            	if (turret_charges > 0 && window_timer == 1) { 
				    sentry = instance_create(x, y, "obj_article3");
				    array_insert(turrets, 0, sentry);
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
    if (right_down || left_down) {
    	hsp += (!free) ? ((1+walk_accel)* (1 +(-2*left_down))) : ((air_accel)*(1 +(-2*left_down)));
    	hsp = (!free) ? (clamp(hsp, -walk_speed, walk_speed)) : (clamp(hsp, -air_max_speed, air_max_speed));
    } else {
    	hsp = (!free) ? (hsp*air_friction) : (hsp*ground_friction);
    }
    
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
