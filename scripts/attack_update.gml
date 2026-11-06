// attack_update



//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL) {
    trigger_b_reverse();
}

// if free && strong_down {
// 	attack = AT_EXTRA_2;
// }
// if joy_pad_idle != true {
// 	weapon_aim = joy_dir;
// }
if has_rune_spawn_point && special_down && attack_down && ult_charge >= ult_cost {
	attack = AT_EXTRA_2;
	state_timer = 0;
	window = 1;
	window_timer = 0;
}

// One-time changes
switch(attack) {
    
    case AT_EXTRA_1 : //Reload
    	if window == 2 && window_timer == 1	{	ammo = max_ammo;	}
    	weapon_aim = (90*(1-spr_dir));	// Reset weapon aim.
        orb_h = (90*(1-spr_dir));
        orb_v = 0;
    	break;
    	
    case AT_EXTRA_2 : //ultimate
    	if has_rune_spawn_point {
    		switch(window) {
				case 1:
				break;
            case 2:
            	if !instance_exists(teleporter_ultimate) {
            		teleporter_ultimate = instance_create(x, y, "obj_article2");
                    teleporter_ultimate.type = "ultimate";
                    teleporter_ultimate.state = -1;
            	}
            	    if special_pressed & !attack_pressed && state_timer > 6 { //place
                		teleporter_ultimate.state = 0;
                		teleporter_ultimate.damage_cd = 0;
                		ult_charge = 0;
                        sound_play(sound_get("teleporter deployment 2"));
                        window = 3;
                		window_timer = 0;
                	}
                	if attack_pressed & !special_pressed { //cancel placement
                		instance_destroy(teleporter_ultimate);
                		window = 3;
                		window_timer = 0;
                	}
                break;
            case 3:
            	break;
    		}
    	}
    	break;
    
    	
    case AT_TAUNT:
    	if ammo < max_ammo {	set_attack(AT_EXTRA_1);   	} // Switch to reload if necessary.
    	break;
    	
    case AT_JAB :
        if !has_rune_beam_lock_on { // If stick beam
        	switch(window) {
            case 1:
                aim_speed = 0;
                weapon_aim = (90*(1-spr_dir));
				beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
                if (ammo <= 0) {	set_attack(AT_EXTRA_1);	} // Force reload if ammo is empty
                break;

            case 2:
            	beam_length = 0; // Reset beam length
            	
            	if (ammo > 0) {	ammo--;	}		// Deplete ammo
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
				
                    beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim));
                    beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim));
                    
                    with oPlayer { // Scanning players
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
            			// if charge > 0 { charge -= charge_decay; }
            			clamp(charge, 0, charge_max)
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
                aim_speed = 0;  // reset aim speed
                weapon_aim = (90*(1-spr_dir)); // set weapon aim to directly in front of you
				beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
                beam_list = [];
                break;
        }
        break;
	    }
	    else {
	    	switch(window) {
	            case 1:
	            	aim_speed = 0;
	                weapon_aim = (90*(1-spr_dir));
					beam_length = 0; // Set to 0 to avoid visual glitches such as the beam extending past targets
					beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
					beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
	                if (ammo <= 0) {	set_attack(AT_EXTRA_1);	} // Force reload if ammo is empty
	                break;
	            case 2:
	            	// beam_length = 0; // Reset beam length
	            	if (ammo > 0) {	ammo--;	}		// Deplete ammo
	            	if ammo <= 0 {	beam_length = 0; }	// Hide beam if theres no ammo
	            	
	            	// beam_list = []; 	// Clear list each tick. Prevents getting duplicates of the same person
	            	
	            	
	            	if attack_down && ammo > 0 {		// Aiming Mode. Lets you move the beam, even while locked on!
	            		
	            		if up_down || down_down {		// Aim up or down
	            			beam_target = noone;
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
	                    
	                    
	                	// if (weapon_aim == 90 && spr_dir == -1) || (weapon_aim == 270 && spr_dir == 1) {aim_speed = clamp(aim_speed, 0, max_aim_speed); }//Clamp to prevent beam from going behind the head
						// if (weapon_aim == 270 && spr_dir == -1) || (weapon_aim == 90 && spr_dir == 1){aim_speed = clamp(aim_speed,-max_aim_speed, 0); }//Clamp to prevent beam from going behind the back
	                   
	                    
						if beam_target == noone { // If there isn't a beam target
							beam_list = [] // Clear beam list each frame to prevent duplicates
							switch(spr_dir){	// Weapon can't be aimed past your head or behind you
								case -1:
									weapon_aim = clamp(weapon_aim, 90, 270);
									break;
								case 1:
									if weapon_aim >= 90 && weapon_aim <= 180 {	weapon_aim = 90;	}
									if weapon_aim <= 270 && weapon_aim >= 180 {	weapon_aim = 270;	}
									break;
								break;
	                    	}
	                		weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)); // X location of the start of the beam
							weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)); // Y location of the start of the beam
							beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim)); // X location of the end of the beam
							beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim)); // Y location of the end of the beam
	                    	// switch(spr_dir) {	// switch direction
	                    	// 	case -1:	if (weapon_aim < 90 && weapon_aim >= 0) || (weapon_aim <= 360 && weapon_aim > 270) {spr_dir = 1;} break;
	                    	// 	case 1:		if weapon_aim > 90 && weapon_aim < 270 {spr_dir = -1;}	break;
	                    	// }
							with oPlayer { // Scan players
								if (player != other.player && get_player_team(player) != get_player_team(other.player)) {	// If not me and not on my team
									var b_dist = point_distance(x, y - (char_height/2), other.weapon_x, other.weapon_y);		// Document enemy distance from weapon
									//var b_dist = distance_to_point(other.weapon_x, other.weapon_y);
									if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) && b_dist < other.beam_max_range { // && b_dist > other.arm_offset_y
										if array_find_index(other.beam_list, b_dist) == -1 {	// If not in the list
											array_push(other.beam_list, b_dist);		// Add to the list of people the beam can hit
										}
									}
								}
							}
							if array_length(beam_list) > 0 {	// If there are eligible targets
	            				for (i = 0; i < array_length(beam_list); i++;) {	// Descend through list of eligible targets
	            					array_sort(beam_list, true);	// Sort list by distance
	            				}
	            				with oPlayer {
	            					if player != other.player && get_player_team(player) != get_player_team(other.player) {
	            						if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, hurtboxID, false, false) {
	            				 			if point_distance(x, y - (char_height/2), other.weapon_x, other.weapon_y) == other.beam_list[0] { // If distance between the start of the beam and the midline of the enemy match
	            				 			// if distance_to_point(other.weapon_x, other.weapon_y) == other.beam_list[0] {
	            								other.beam_target = id;
	            							}
	            						}
	            					}
	            				}
	            			}
	            			else {
	            				beam_length = beam_preview_range;	// If no one in range, set beam length to preview
	            			}
	            			if charge > 0 { charge -= charge_decay; }
	            			clamp(charge, 0, charge_max)
	            			beam_chip = 0;
	            			beam_length = beam_preview_range;
	            			
	            			beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
							beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
	            		}
	            		else { // If there is a beam target
	            			beam_list = [];
	            			weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)); // X location of the start of the beam
							weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)); // Y location of the start of the beam
							beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim)); // X location of the end of the beam
							beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim)); // Y location of the end of the beam
	            			with beam_target {
	            			 	if other.beam_length > other.beam_max_range || (invincible == true || state == PS_AIR_DODGE || state == PS_SPAWN || state == PS_DEAD || state == PS_RESPAWN || state == PS_ROLL_BACKWARD || state == PS_ROLL_FORWARD || state == PS_WALL_TECH) { //If target is inside the weapon, out of range, or unable to hit
	            					other.beam_target = noone;
	            					other.beam_chip = 0;
	            					other.weapon_aim = (90*(1-other.spr_dir)); //other.beam_length <= other.arm_offset_y ||
	            			 	}
	            			 	else {
	            			 		if (other.charge < other.charge_max) {		// If not at max charge
	            						other.charge += min(other.charge_max - other.charge, 1);	// Charge beam
	            						other.charge = clamp(other.charge, 0, other.charge_max);
	        						}
	            			 		other.beam_chip++;
	            			 		other.beam_x = x;
	            			 		other.beam_y = y - (char_height/2);
	            			 		other.beam_length = point_distance(other.weapon_x, other.weapon_y, other.beam_x, other.beam_y);
	            			 		// other.weapon_aim = point_direction(other.weapon_x, other.weapon_y, other.beam_x, other.beam_y);
	            			 		other.weapon_aim = point_direction(other.x - other.spr_dir*other.arm_offset_x, other.y-other.arm_offset_y, other.beam_x, other.beam_y);
	            			 		if other.weapon_aim > 90 && other.weapon_aim < 270 {other.spr_dir = -1;}
	            			 		if other.weapon_aim < 90 || other.weapon_aim > 270 {other.spr_dir = 1;}
	    							}
	            			}
	            			if beam_chip >= beam_chip_threshold {
	            			 	take_damage(beam_target.player, player, 1);
	            			 	beam_chip = 0;
	            			}
						}
						// if beam_target == noone {	beam_length = beam_preview_range;	}	// overwrite and set to preview
						
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
	                aim_speed = 0; // reset aim speed
	                weapon_aim = (90*(1-spr_dir)); // set weapon aim to directly in front of you
					beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
	                beam_list = [];
	                break;
	        }
	        break;
	    }

        
    case AT_FSPECIAL :
    	switch(window) {
    		case 1:
    			if (barrier_timer > 0 || barrier_placing == true) {
    				set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
    			}
    			else {
    				reset_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME);
    			}
    			// if up_down || down_down {
       //         		if up_down {
       //         			set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_VSPEED, -1);
       //         			set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 1);
       //         		}
       //         		if down_down {
       //         			set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 0);
       //         			set_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME, 360);
       //         			// set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 1);
       //         		}
                		
       //         }
       //         else {
                	reset_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_VSPEED);
                	reset_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED);
                	reset_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME);
                // }
    			
    			break;
    		case 2:
    			if barrier_placing == true {set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);}
    			if has_rune_remote_place && special_down { barrier_placing = true; }
    			else { barrier_placing = false; window = 3; window_timer = 0;}
    			break;
    		case 3:
    			barrier_placing = false;
    			if has_rune_remote_place { pHitBox.hsp = 0;}
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
    	
    	if special_down {
    		// switch(spr_dir) {	// Weapon can't be aimed past your head or behind you
      //      	case -1:
      //      		weapon_aim = clamp(weapon_aim, 90, 270);
      //      		break;
      //      	case 1:
      //      		if weapon_aim > 90 && weapon_aim < 180 {	weapon_aim = 90;	}
      //      		if weapon_aim > 180 && weapon_aim < 270 {	weapon_aim = 270;	}
      //              break;
      //      }
    		
    		
    		
    		//Reset weapon aim when flipping directions
    		// if left_down && !right_down && spr_dir == 1 { spr_dir =-1; weapon_aim = (90*(1-spr_dir));} //Flip direction and reset weapon aim
      //      if right_down && !left_down && spr_dir == -1 { spr_dir = 1; weapon_aim = (90*(1-spr_dir));}
			// weapon_aim = (spr_dir == 1 && left_down && !right_down) ? (90*(1-spr_dir)) : weapon_aim; // If facing right
		
            
    		if window != 4 && (up_down || down_down) {			// Aiming Mode disabled during release window
            	if up_down && !down_down{	aim_speed += aim_accel*spr_dir;}
            	if down_down && !up_down {	aim_speed -= aim_accel*spr_dir;}
            }
            else { if aim_speed > 0 || aim_speed < 0 { aim_speed = aim_speed*aim_decel; }}	// Decelerate if you aren't aiming
            
        	weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)); //Set weapon x location for where the orb will fire from
			weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)); //Set weapon y location for where the orb will fire from
            aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);	// Aim speed doesn't go past max speed
            weapon_aim += aim_speed;	// Weapon aim is modified by aim speed/acceleration
            weapon_aim = (up_down || down_down) ? weapon_aim : round(weapon_aim); //Aiming is accurate, not aiming rounds to nearest degree
            weapon_aim = (weapon_aim >= 360) ? 0 : weapon_aim;	// Resets aim if you go past 360, otherwise the same
            weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0, otherwise the same
            weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
            switch(spr_dir) {	// Weapon can't be aimed past your head or behind you
            	case -1:
            		weapon_aim = clamp(weapon_aim, 90, 270);
            		break;
            	case 1:
            		if weapon_aim > 90 && weapon_aim < 180 {	weapon_aim = 90;	}
            		if weapon_aim > 180 && weapon_aim < 270 {	weapon_aim = 270;	}
                    break;
            }
            orb_h = orb_speed*dcos(weapon_aim);
            orb_v = orb_speed*dsin(weapon_aim);
    	}
    	else {
    		if aim_speed = 0 { weapon_aim = (90*(1-spr_dir)); }//if not firing orbs, set weapon aim to the sprite direction
    	}
        switch(window) {
        	case 1: //start
        		if state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR {		//start of the move. dont use window == 1
        			aim_speed = 0; //Reset aim speed
        			weapon_aim = 90*(1-spr_dir); //Reset aim to directly in front of you
        			if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}		//Reload if no ammo
        			reset_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME);
                	reset_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME);
                	
                	set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99); //Delay creation of charged orb
                	
        			switch(spr_dir) {	// Weapon can't be aimed past your head or behind you
                    	case -1:
                    		if weapon_aim < 90 && weapon_aim >= 0 { weapon_aim = abs(180 - weapon_aim); }
                    		if weapon_aim > 270 && weapon_aim <= 360 { weapon_aim = 180 + abs(360 - weapon_aim);	}
                    		break;
                    	case 1:
                    		if weapon_aim > 90 && weapon_aim <= 180 {	weapon_aim = abs(180 - weapon_aim);	}
                    		if weapon_aim < 270 && weapon_aim > 180 {	weapon_aim = 180 + abs(360 - weapon_aim);	}
                    		
                    		
                    		break;
                    }
        			// weapon_aim = 180*floor(weapon_aim/180)	+ abs((180*floor(weapon_aim/180) + 180) - weapon_aim);		// Sets weapon aim to similar angle when switching sides
        		}
                break;
            case 2: //charge
            	if (special_down) {
            		// Charged
            		reset_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME);
            		set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
            		
            		
            		// orb_h = round(orb_h);
            		// orb_v = round(orb_v);
            		
            		
            	}
            	else {
            		window = 4;
            		window_timer = 0;
            	}
            	
                // if left_pressed { spr_dir = -1; weapon_aim = 180;}
                // if right_pressed { spr_dir = 1; weapon_aim = 0;}
                break;
            case 3: // hold
            	sound_stop(sound_get("orb charging 1"));
            	// aim_speed = 0;
            	if state_timer > 60 { //If held orb to max
            			window = 4;
            			window_timer = 0;
            	}
            	if (!special_down) {window = 4;	window_timer = 0;}
            	
            	
            	break;
            case 4:
            	
            	//The angle the orb fires at
            	set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_HSPEED, spr_dir*orb_h);
            	set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_VSPEED, -orb_v);
            	
            	//Where the orb fires from
            	set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_X, spr_dir*beam_offset*dcos(weapon_aim) - arm_offset_x);
            	set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_Y, -beam_offset*dsin(weapon_aim) - arm_offset_y);
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
            	if window_timer == (get_window_value(AT_NSPECIAL, 4, AG_WINDOW_LENGTH) - 1) && special_down { //If window expired but still firing
            		window = 2; //restart charging phase for next orb
            		window_timer = 0;
            		state_timer = 0;
            	}
            	else { //If you stop firing and this is your last orb
            		// weapon_aim = 90*(1-spr_dir); //reset aim to directly in front of you
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
            	if instance_exists(teleporter_entrance) {	teleporter_entrance.state = 1;	spawn_hit_fx(teleporter_entrance.x,teleporter_entrance.y-32,HFX_GEN_OMNI);	tp_timer = tp_rate;}
            	if instance_exists(teleporter_exit) {	teleporter_exit.state = 1;	spawn_hit_fx(teleporter_exit.x,teleporter_exit.y-32,HFX_GEN_OMNI); tp_timer = tp_rate;}
            	// tpx_x = x + (192*spr_dir);
				// tpx_xv = 0;
				// tpx_y = y;
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
                        	// teleporter_entrance.state = -1;
                        	array_insert(teleporters, 0, instance_find(teleporter_entrance, 1));
                    	}
                        if !instance_exists(teleporter_exit) {
                        	teleporter_exit = instance_create(x + (39*spr_dir), y, "obj_article2");
                        	teleporter_exit.type = "exit";
                        	// teleporter_exit.state = -1;
                        	array_insert(teleporters, 1, instance_find(teleporter_exit, 1));
                        	sound_play(sound_get("preview"));
                        }
                    }
                    if !instance_exists(teleporter_entrance) || !instance_exists(teleporter_exit) {
                		move_cooldown[AT_USPECIAL] = 4;
                    }
                }
                 
                break;
            case 3:
            	if (tp_timer <= 0 && window_timer == 1 && instance_exists(teleporter_entrance) && instance_exists(teleporter_exit)) {
            		if !teleporter_exit.free { //If teleporter exit is on the ground
            			teleporter_entrance.state = 0;
						teleporter_entrance.damage_cd = 0; //invulnerability ends
                		teleporter_exit.state = 0;
						teleporter_exit.damage_cd = 0; //invulnerability ends
                		sound_play(sound_get("teleporter deployment 2"));
                		// tp_timer = tp_rate;
            		}
            		else {
            			teleporter_entrance.state = 1;
            			teleporter_exit.state = 1;
            		}
            	}
            	else {
            		// move_cooldown[AT_USPECIAL] = tp_timer;
            	}
        		break;
        }
        break;
    
    case AT_DSPECIAL :	// Turrets
    	var new_turret = noone; // Null instance id.
        switch(window) {
        	case 1 :
        		if window_timer == 1 { // Only execute on first frame.
        			if has_rune_more_turrets {
        				turrets = deployable_destroy(turrets, turrets[0]); // Destroy oldest turret, if possible.
        			}
        			else{
        				turrets = deployable_destroy_all(turrets);
        				move_cooldown[AT_DSPECIAL] = 4;	// Add cooldown if it's only one turret.
        			}
        		}
        		break;
        	
            case 2 : // Preview
            	if window_timer == 1 { // Only execute on first frame.
            		// Cancel if you can't create turrets.
            		if turret_charges <= 0 {	move_cooldown[AT_DSPECIAL] = 4; }
            	}
            	if !special_down && state_timer > 20 {	// If special button released...
            		window = 3;	// Switch to next attack window.
            		window_timer = 0;
                }
                break;
            
            case 3 : // Deploy
            	if window_timer == 1 && turret_charges > 0 && turret_timer <= 0 { // Only execute on first frame
            		if !instance_exists(new_turret) {
            			// Place grounded turrets on the ground,
            			// Place aerial turrets at the midline of the character.
            			var turret_y_offset = free ? y-char_height/2 : y-18;
	            		new_turret = deployable_create(turrets, "obj_article3", x, turret_y_offset);
            		}
            		if instance_exists(new_turret) {
						new_turret.can_be_grounded = !free;
	            		new_turret.is_healing = has_rune_turret_heal;
	            		new_turret.is_weak_turret = has_rune_more_turrets;
	            		turret_timer += turret_rate;
	        			turret_charges--;
	                	move_cooldown[AT_DSPECIAL] = 4; //Cooldown before placing next turret
            		}
            		else {	print_debug("ERROR: Failed to create sentry turret!");	}
			    }
                break;
		}
		break;
}


//Movement
if (attack == AT_NSPECIAL || attack == AT_JAB || attack == AT_DSPECIAL || attack == AT_EXTRA_2)  { //&& window == 2
	
	draw_indicator = false;		// Hide indicator while aiming
	
    // Single Jump
    if jump_pressed && !free {
    	clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
    }
	
	// Walking or Falling
    if (right_down || left_down) {
    	//Change direction
		if attack == AT_EXTRA_2 {spr_dir = (1 +(-2*left_down)); }
    	hsp += (!free) ? ((1+walk_accel)* (1 +(-2*left_down))) : ((air_accel)*(1 +(-2*left_down)));
    	hsp = (!free) ? (clamp(hsp, -walk_speed, walk_speed)) : (clamp(hsp, -air_max_speed, air_max_speed));
    } else {
    	hsp = (!free) ? (hsp*air_friction) : (hsp*ground_friction);
    }
    
    // Cannot double jump or dash/sprint while aiming. //
}

#define deployable_destroy(instance_array, old_instance)
instance_array = clear_instance_from_array(instance_array, old_instance);

// Move existing instances to the front of the array.
var instance_array_length = array_length(instance_array);
var new_array = [];
for (i = 0; i < array_length(instance_array); i++;) {
	if instance_array[i] != noone {
		array_push(new_array, instance_array[i]);	// Add existing instance.
	}
}
// Add empty slots in the back of the array.
var new_array_length = array_length(new_array);
for (i = new_array_length - 1; i < instance_array_length; i++;) {
	array_push(new_array, noone);	// Add non-existant instance.
}

instance_array = array_clone(new_array);
return instance_array;

#define deployable_destroy_all(instance_array)
for (i = 0; i < array_length(instance_array); i++;) {
	var old_instance = instance_array[i];
	instance_array = clear_instance_from_array(instance_array, old_instance);
}
return instance_array;


#define deployable_create(instance_array, instance_name, x_value, y_value)
// Find an empty slot in the array.
var instance_index = -1;
var last_index = array_length(instance_array) - 1;
for (i = 0; i < array_length(instance_array); i++;) {
	var current_instance = instance_array[i];
	if current_instance == noone { instance_index = i;} // If empty, use this slot.
	if i == last_index && current_instance != noone {
		deployable_destroy(instance_array, current_instance); // If no slots are empty, clear the first slot.
		instance_index = last_index;
	}
}

if instance_array[instance_index] != noone {	// If the index has an instance...
	instance_array = deployable_destroy(instance_array, instance_index);	// Clear the index and update the array.
}

var new_instance = instance_create(x_value, y_value, instance_name);
if (instance_exists(new_instance) && "state" in new_instance) {
	new_instance.state = -1; // Set to preview
	new_instance.state_timer = 0;
}
array_push(instance_array, new_instance);
return new_instance;

#define deployable_activate(old_instance)
if (instance_exists(old_instance) && "state" in old_instance) {
	old_instance.state = 0; // Set to idle
	old_instance.state_timer = 0;
}

#define clear_instance_from_array(instance_array, old_instance)
var new_array = array_clone(instance_array);
if (instance_exists(old_instance) && "state" in old_instance) {
	var old_index = array_find_index(instance_array, old_instance);
	old_instance.state = 2; // Set to destroying.
	old_instance.state_timer = 0;
	if old_index != -1 {
		new_array[old_index] = noone;	// Clear old instance from array.
	}
}
instance_array = new_array;
return instance_array;


