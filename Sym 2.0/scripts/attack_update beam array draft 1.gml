// attack_update


//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

if free && strong_down {
	attack = AT_EXTRA_2;
}

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
                // Resets the variables and aim
                weapon_aim = (90*(1-spr_dir));
                beam_x = x - spr_dir*arm_offset_x + round(beam_preview_range*real(dcos(weapon_aim)));
				beam_y = y - arm_offset_y - round(beam_preview_range*real(dsin(weapon_aim)));
                aim_speed = 0;
                o_dist = 0;
                o_angle = 0;
                if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}
                break;
                
            case 2:
            	if (ammo > 0) {	ammo--;	}		// Deplete ammo
            	if beam_target == noone {	// Aiming Reticle before lock on
            			
                	// aim_speed = (up_down || down_down) ? aim_speed + (aim_accel*(1 + (-2*down_down))*spr_dir) : aim_speed*aim_decel;	// if pressing up or down, aim speed will accelerate according to which button is pressed and the sprite direction. If nothing is pressed, aim speed decelleratess.
                    aim_speed = (up_down || down_down) ? aim_speed + (aim_accel*-down_down*spr_dir) + (aim_accel*up_down*spr_dir) : aim_speed*aim_decel;
                    // clamp(aim_speed, (aim_speed-aim_speed)/2, (aim_speed+aim_speed)/2);		// Clamp aimspeed to stop decelerating at 0
                    // aim_speed = (up_down || down_down) ? aim_speed * max(abs(aim_speed), 1) : aim_speed;		// Aim speed increases exponentially if firing
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
                    
                    beam_x = x - spr_dir*arm_offset_x + round(beam_length*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
					beam_y = y - arm_offset_y - round(beam_length*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
					beam_length = beam_preview_range;		// Beam length is at preiview range when not targeting anyone
					
					beam_line_x = x + beam_range*(dcos(weapon_aim));		// All X values the beam could hit
					beam_line_y = y - beam_range*(dsin(weapon_aim));		// All Y values the beam could hit
					if (!up_down && !down_down) {
					with oPlayer {
						if (player != other.player && get_player_team(player) != get_player_team(other.player)) {
							var o_dist = point_distance(x, y-char_height/2, other.x - other.spr_dir*other.arm_offset_x + round(other.beam_offset*dcos(other.weapon_aim)), other.y - other.arm_offset_y - round(other.beam_offset*dsin(other.weapon_aim)));		// Distance between target and player
							var o_angle = point_direction(other.x - other.spr_dir*other.arm_offset_x + round(other.beam_offset*dcos(other.weapon_aim)), other.y - other.arm_offset_y - round(other.beam_offset*dsin(other.weapon_aim)), x, y-char_height/2);		// View angle of player
							// if (o_dist <= other.beam_range && instance_place(y*(1/dtan(other.weapon_aim)), x*dtan(other.weapon_aim), hurtboxID)) { // If the opponent is within range, in front of you, and the weapon is aimed at them, target them.
							// 	other.beam_x = x;
							// 	other.beam_y = y - char_height/2;
							// 	other.beam_length = o_dist;
							// 	other.weapon_aim = o_angle;
							// }
							
							// var line_dist = point_distance(x, y-char_height/2, other.x, other.y - other.arm_offset_y);
							if collision_line(other.x - other.spr_dir*other.arm_offset_x + round(other.beam_offset*dcos(other.weapon_aim)), other.y - other.arm_offset_y - round(other.beam_offset*dsin(other.weapon_aim)), other.beam_x, other.beam_y, hurtboxID, false, false) {	// If I (enemy player) have my hurtbox collide with the beam line.
								if array_find_index(other.beam_list, id) == -1 {
									array_push(other.beam_list, id);		// Add me to the list of people the beam can hit
									other.y -= 16;
								}
							}
							else {
								
							}
						}
            		}
					
            		
            		for (i = 0; i < array_length(beam_list); i++;) {	// Descend through beam list
					if array_length(beam_list) > 1 {
						if collision_line(x - spr_dir*arm_offset_x + round(beam_offset*dcos(weapon_aim)), y - arm_offset_y - round(beam_length*dsin(weapon_aim)), beam_x, beam_y, beam_list[i], false, false)	// If still colliding with beam
						// && point_direction(x - spr_dir*arm_offset_x + round(beam_offset*dcos(weapon_aim)), y - arm_offset_y - round(beam_offset*dsin(weapon_aim)), beam_list[i].x, beam_list[i].y - beam_list[i].char_height/2)	== weapon_aim	// AND aligned with weapon angle
						&& point_distance(beam_list[i].x, beam_list[i].y - beam_list[i].char_height/2, x - spr_dir*arm_offset_x + round(beam_offset*dcos(weapon_aim)), y - arm_offset_y - round(beam_offset*dsin(weapon_aim))) <= beam_range	// AND still in range
						&& ((spr_dir == -1 && beam_list[i].x < x) || (spr_dir == 1 && beam_list[i].x > x))				// AND in same direction
						{		
							if i != array_length(beam_list) {
								// beam_list[i].o_dist = point_distance(beam_list[i].x, beam_list[i].y-char_height/2, x, y - arm_offset_y);
								if beam_list[i+1].o_dist < beam_list[i].o_dist {	// If closer than last entry
									beam_list[i+1] = id;
								}
								else {
									// array_sort
								}
							}
						}
						else {
							beam_list[i] = 0;
						}
					}
					else {
						if collision_line(x - spr_dir*arm_offset_x + round(beam_offset*dcos(weapon_aim)), y - arm_offset_y - round(beam_length*dsin(weapon_aim)), beam_x, beam_y, beam_list[i].hurtboxID, false, false) {
							beam_target = beam_list[i];
						}
						else {
							beam_list[i] = 0;
							beam_target = noone;
						}
					}
            		}
					}
            	}	
            	else {
            		if (!up_down && !down_down) {	// Maintain aim if angle is not manually changed
            			
            			// beam_list = [];
            			aim_speed = 0;
            			// weapon_aim = point_direction(x - spr_dir*arm_offset_x + round(beam_length*dcos(weapon_aim)), y - arm_offset_y - round(beam_length*dsin(weapon_aim)), beam_target.x, beam_target.y-beam_target.char_height/2);
            			beam_length = point_distance(beam_target.x, beam_target.y-beam_target.char_height/2, x - spr_dir*arm_offset_x + round(beam_length*dcos(weapon_aim)), y - arm_offset_y - round(beam_length*dsin(weapon_aim)));
            			
            			if (beam_length <= beam_range || beam_timer > 0 && beam_length <= beam_max_range) {
            				
            				if (weapon_aim > 90 && weapon_aim < 270) {	spr_dir = -1;	}
            				else {	spr_dir = 1;	}
            				beam_x = beam_target.x;
            				beam_y = beam_target.y - beam_target.char_height/2;
            				
            				if beam_length <= beam_range {
            					beam_timer = beam_lock_time;
            				}
            				if (charge < c_level3max) {
            					charge += min(c_level3max - charge, 1);
            					clamp(charge, 0, c_level3max);
        					}
        					
            			}
            			else {
                			beam_target = noone;
            			}
            		}
            		else {
            			beam_target = noone;	// Disconnects if you attempt to aim past target
            		}
            		
            	}
            	
				
            	
            	// Auto-lock charges
				// if (charge < c_level2) { charge_length = c_level1_length; }
				// if (charge >= c_level2 && charge < c_level3) { charge_length = c_level2_length; }
				// if (charge >= c_level3 ) { charge_length = c_level3_length; }
				// set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, charge_length);
				// set_hitbox_value(AT_JAB, 1, HG_LIFETIME, charge_length);
					
                if ammo <= 0 {	beam_length = 0; }
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
            		
            		aim_speed = (up_down || down_down) ? aim_speed + (aim_accel*(1 + (-2*down_down))*spr_dir) : aim_speed*aim_decel;	// if pressing up or down, aim speed will accelerate according to which button is pressed and the sprite direction. If nothing is pressed, aim speed decelleratess.
                   	
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

if (attack == AT_JAB && window = 2) {
	draw_indicator = false;
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
    	hsp = (!free) ? (hsp*air_friction) : (hsp*ground_friction);
    	// hsp = (!free) ? (hsp - (walk_accel*(1 +(-2*left_down)))) : (air_accel*(1 +(-2*left_down)));
    	//hsp = (!free) ? (clamp(hsp, -(walk_speed), (walk_speed))) : (clamp(hsp, -air_speed, air_speed));
    	// hsp = 0;
    }
}

if ((attack == AT_NSPECIAL || attack == AT_JAB) && jump_pressed && !free) {
	clear_button_buffer(PC_JUMP_PRESSED);
	vsp = -jump_speed;
	sound_play(asset_get("sfx_jumpground"));
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
