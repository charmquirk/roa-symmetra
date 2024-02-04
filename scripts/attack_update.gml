// attack_update



//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

// if free && strong_down {
// 	attack = AT_EXTRA_2;
// }
// if joy_pad_idle != true {
// 	weapon_aim = joy_dir;
// }
if has_rune("L") && special_down && attack_down && ult_charge >= ult_cost {
	attack = AT_EXTRA_2;
	state_timer = 0;
	window = 1;
	window_timer = 0;
}

// One-time changes
switch(attack) {
    
    case AT_EXTRA_1 : //Reload
    	switch(window) {
    		case 2:
    			if (window_timer == 1) {	ammo = max_ammo;	}		 // Reloads weapon
    	}
    	weapon_aim = (90*(1-spr_dir));
        orb_h = (90*(1-spr_dir));
        orb_v = 0;
    	break;
    	
    case AT_EXTRA_2 : //ultimate
    	if has_rune("L") {
    		switch(window) {
				case 1:
				break;
            case 2:
            	if !instance_exists(teleporter_ultimate) {
            		teleporter_ultimate = instance_create(x,y,"obj_article2");
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
    	if ammo < max_ammo {	set_attack(AT_EXTRA_1);   	}
    	break;
    	
    case AT_JAB :
        if has_rune("G") { // If stick beam
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
    else { // If lock-on beam
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
    			if has_rune("F") && special_down { barrier_placing = true; }
    			else { barrier_placing = false; window = 3; window_timer = 0;}
    			break;
    		case 3:
    			barrier_placing = false;
    			if has_rune("F") { pHitBox.hsp = 0;}
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
    
    case AT_DSPECIAL :
        switch(window) {
        	case 1 : //start
        		if has_rune("E") { //if you can only have one turret
        			if instance_exists(sentry) && window_timer == 1{
        				sentry.state = 2; //destroy turret
        				turret_timer += turret_rate;
        				move_cooldown[AT_DSPECIAL] = 12;
        			}
        		}
        		break;
            case 2: //deploy
                if (turret_charges > 0 && turret_timer <= turret_rate*(max_turrets-turret_charges) && turret_placing == false) { // if there are charges, and it sthe beginning of the windo and timer is below
                	if has_rune("I") { //Aerial flying Turrets
            			sentry = instance_create(x, y - char_height/2 - 18, "obj_article3");
            			sentry.flying_dir = spr_dir;
            			sentry.hsp = sentry.max_flying_speed*sentry.flying_dir;
            			sentry.damage_cd = 0;
            			if !has_rune("E") { //if you can have more than 1 turret
							array_push(turrets, sentry);
            			}
            			if (has_rune("E") && !has_rune("F")) || !has_rune("E") { //if you only have one turret max, it flies, and can't be placed OR if you can have multiple turrets
            				turret_timer += turret_rate; //start cooldown immediately
            				move_cooldown[AT_DSPECIAL] = 12; //Cooldown before placing next turret
						}
                    	sound_play(sound_get("preview"));
                    	turret_charges--;
                    	turret_placing = true;
                	}
                }
                if !special_down { //release special
                	if has_rune("I") && has_rune("F") && instance_exists(sentry) { sentry.hsp = 0; }//Aerial turrets and stop objects
                    window = 3;
                    window_timer = 0;
                }
                invisible = true;
                break;
            case 3: //end
            	turret_placing = false;
            	if (turret_charges > 0 && window_timer == 1) {
            		
            		if !has_rune("I") { // Stationary turrets
            			if free { sentry = instance_create(x, y-char_height/2, "obj_article3"); }
            			else { sentry = instance_create(x, y-18, "obj_article3"); sentry.can_be_grounded = true;}
            			sentry.damage_cd = 0;
            			if !has_rune("E") { //if you have multiple turrets
            				array_push(turrets, sentry);
                    		turret_timer += turret_rate;
            			}
            			// print_debug("Placed");
            			turret_charges--;
                    	move_cooldown[AT_DSPECIAL] = 12; //Cooldown before placing next turret
						sound_play(sound_get("preview"));
            		}
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



// #define scan_objects
// //scan_objects(index, ...values)
// // Used in a for loop's with statement to scan multiple objects
// // with (scan_objects(index, obj1, obj_2, obj_3))

// return argument[argument[0] + 1];
