// attack_update		runs while attacking.



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

// Trigger ultimate if possible.
if special_down && attack_down && ult_charge >= ult_cost {
	if has_rune_shield_gen || has_rune_spawn_point || has_rune_shield_wall {
		attack = AT_EXTRA_2;
		state_timer = 0;
		window = 1;
		window_timer = 0;
	}
}

// One-time changes
switch(attack) {
    
    case AT_EXTRA_1 : //Reload
    	if window == 2 && window_timer == 1	{	ammo = max_ammo;	}
    	weapon_aim = (90*(1-spr_dir));	// Reset weapon aim.
        orb_h = (90*(1-spr_dir));
        orb_v = 0;
    	break;
    	
    case AT_EXTRA_2 : // Ultimate
    	// if has_rune_spawn_point {
     //   	if window == 2 && !instance_exists(teleporter_ultimate) {
     //   		teleporter_ultimate = instance_create(x, y, "obj_article2");
     //           teleporter_ultimate.type = "ultimate";
     //           teleporter_ultimate.state = -1;
        	
    	//     if special_pressed & !attack_pressed && state_timer > 6 { //place
     //   		teleporter_ultimate.state = 0;
     //   		teleporter_ultimate.damage_cd = 0;
     //   		ult_charge = 0;
     //           sound_play(sound_get("teleporter deployment 2"));
     //           window = 3;
     //   		window_timer = 0;
     //   	}
     //   	if attack_pressed & !special_pressed { //cancel placement
     //   		instance_destroy(teleporter_ultimate);
     //   		window = 3;
     //   		window_timer = 0;
     //   	}
    	break;
    	
    case AT_TAUNT:
    	if ammo < max_ammo {	set_attack(AT_EXTRA_1);   	} // Switch to reload if necessary.
    	break;
    	
    // case AT_JAB :
    //     if !has_rune_beam_lock_on { // If stick beam
    //     	switch(window) {
    //         case 1:
    //             aim_speed = 0;
    //             weapon_aim = (90*(1-spr_dir));
				// beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
    //             if (ammo <= 0) {	set_attack(AT_EXTRA_1);	} // Force reload if ammo is empty
    //             break;

    //         case 2:
    //         	beam_length = 0; // Reset beam length
            	
    //         	if (ammo > 0) {	ammo--;	}		// Deplete ammo
    //         	if ammo <= 0 {	beam_length = 0; }	// Hide beam if theres no ammo
            	
    //         	beam_list = []; 	// Clear list each tick. Prevents getting duplicates of the same person.
            	
    //         	if attack_down && ammo > 0 {		// Aiming Mode. Lets you move the beam.
    //         		if up_down || down_down {		// Aim up or down
    //         			if up_down && !down_down{	aim_speed += aim_accel*spr_dir; }
    //         			if down_down && !up_down {	aim_speed -= aim_accel*spr_dir;	}
    //         		}
    //         		else {
    //         			if aim_speed > 0 || aim_speed < 0 { aim_speed = aim_speed*aim_decel; }	// Decellerate since you aren't aiming
    //         		}
            		
    //         		aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);	// Aim speed maxes out
    //         		weapon_aim += aim_speed;	// Weapon aim is modified by aim speed
    //                 weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;	// Resets aim if you go past 360
    //                 weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0
    //                 weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
    //                 switch(spr_dir){	// Weapon can't be aimed past your head or behind you
    //                 	case -1:
    //                 		weapon_aim = clamp(weapon_aim, 90, 270);
    //                 		break;
    //                 	case 1:
    //                 		if weapon_aim > 90 && weapon_aim < 180 {	weapon_aim = 90;	}
    //                 		if weapon_aim < 270 && weapon_aim > 180 {	weapon_aim = 270;	}
    //                 		break;
    //                 }
    //                 weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim));
				// 	weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim));
				
    //                 beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim));
    //                 beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim));
                    
    //                 with oPlayer { // Scanning players
				// 		if (player != other.player && get_player_team(player) != get_player_team(other.player)) {	// If not me and not on my team
							
				// 			var b_dist = distance_to_point(other.weapon_x, other.weapon_y);		// Document enemy distance from weapon
							
				// 			if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) {
								
				// 				if array_find_index(other.beam_list, b_dist) == -1 {	// If not in the list
				// 					array_push(other.beam_list, b_dist);		// Add to the list of people the beam can hit
				// 				}
				// 			}
				// 		}
    //         		}
    //         		if array_length(beam_list) > 0 {	// If there are eligible targets
    //         			for (i = 0; i < array_length(beam_list); i++;) {	// Descend through list of eligible targets
    //         				array_sort(beam_list, true);	// Sort list by distance
    //         				// print_debug("sorted");
    //         			}
    //         			with oPlayer {
    //         				if player != other.player && get_player_team(player) != get_player_team(other.player) {
    //         				if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, hurtboxID, false, false) {
    //         				 	if distance_to_point(other.weapon_x, other.weapon_y) == other.beam_list[0] {
    //         						other.beam_target = id;
    //         					}
    //         				}
    //         				}
    //         			}
            			
    //         		}
    //         		else {
    //         			beam_length = beam_preview_range;	// If no one in range, set beam length to preview
    //         		}
            		
    //         		if beam_target != noone {
    //         			with beam_target {
    //         			 		if !collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) || (invincible == true || state == PS_AIR_DODGE || state == PS_SPAWN || state == PS_DEAD || state == PS_RESPAWN || state == PS_ROLL_BACKWARD || state == PS_ROLL_FORWARD || state == PS_WALL_TECH) { //If target should be unable to hit
    //         						other.beam_target = noone;
    //         						other.beam_chip = 0;
    //         			 		}
    //         			 		else {
    //         			 			if (other.charge < other.charge_max) {		// If not at max charge
    //         							other.charge += min(other.charge_max - other.charge, 1);	// Charge beam
    //         							other.charge = clamp(other.charge, 0, other.charge_max);
    //     							}
    //         			 			other.beam_chip++;
            			 			
    //         			 			other.beam_length = distance_to_point(other.weapon_x, other.weapon_y);
    // 							}
    //         			}
    //         			if beam_chip >= beam_chip_threshold {
    //         			 	// spawn_hit_fx(beam_target.x, beam_target.y - beam_target.char_height/2, cfx_beam_fire);
    //         			 	take_damage(beam_target.player, player, 1);
    //         			 	beam_chip = 0;
    //         			}
            			
    //         		}
    //         		else {
    //         			// if charge > 0 { charge -= charge_decay; }
    //         			clamp(charge, 0, charge_max)
    //         			beam_chip = 0;
    //         			beam_length = beam_preview_range;
    //         		}
            		
    //         		// if beam_target == noone {	beam_length = beam_preview_range;	}	// overwrite and set to preview
    //         		beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
				// 	beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
            		
    //         	}
    //             else {
    //             	window = 3;
    //             	window_timer = 0;
    //             }
    //             // Auto-lock charges
    //             if (charge < charge_2) { beam_chip_threshold = beam_chip_1; }
				// if (charge >= charge_2 && charge < charge_3) { beam_chip_threshold = beam_chip_2; }
				// if (charge >= charge_3 ) { beam_chip_threshold = beam_chip_3; }
					
                
    //             break;
    //         case 3:
    //         	beam_target = noone;
    //             aim_speed = 0;  // reset aim speed
    //             weapon_aim = (90*(1-spr_dir)); // set weapon aim to directly in front of you
				// beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
    //             beam_list = [];
    //             break;
    //     }
    //     break;
	   // }
	   // else {
	   // 	switch(window) {
	   //         case 1:
	   //         	aim_speed = 0;
	   //             weapon_aim = (90*(1-spr_dir));
				// 	beam_length = 0; // Set to 0 to avoid visual glitches such as the beam extending past targets
				// 	beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
				// 	beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
	   //             if (ammo <= 0) {	set_attack(AT_EXTRA_1);	} // Force reload if ammo is empty
	   //             break;
	   //         case 2:
	   //         	// beam_length = 0; // Reset beam length
	   //         	if (ammo > 0) {	ammo--;	}		// Deplete ammo
	   //         	if ammo <= 0 {	beam_length = 0; }	// Hide beam if theres no ammo
	            	
	   //         	// beam_list = []; 	// Clear list each tick. Prevents getting duplicates of the same person
	            	
	            	
	   //         	if attack_down && ammo > 0 {		// Aiming Mode. Lets you move the beam, even while locked on!
	            		
	   //         		if up_down || down_down {		// Aim up or down
	   //         			beam_target = noone;
	   //         			if up_down && !down_down{	aim_speed += aim_accel*spr_dir; }
	   //         			if down_down && !up_down {	aim_speed -= aim_accel*spr_dir;	}
	   //         		}
	   //         		else {
	   //         			if aim_speed > 0 || aim_speed < 0 { aim_speed = aim_speed*aim_decel; }	// Decellerate since you aren't aiming
	   //         		}
	            		
				// 		aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);	// Aim speed maxes out
				// 		weapon_aim += aim_speed;	// Weapon aim is modified by aim speed
	   //                 weapon_aim = (weapon_aim > 360) ? 0 : weapon_aim;	// Resets aim if you go past 360
	   //                 weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0
	   //                 weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
	                    
	                    
	   //             	// if (weapon_aim == 90 && spr_dir == -1) || (weapon_aim == 270 && spr_dir == 1) {aim_speed = clamp(aim_speed, 0, max_aim_speed); }//Clamp to prevent beam from going behind the head
				// 		// if (weapon_aim == 270 && spr_dir == -1) || (weapon_aim == 90 && spr_dir == 1){aim_speed = clamp(aim_speed,-max_aim_speed, 0); }//Clamp to prevent beam from going behind the back
	                   
	                    
				// 		if beam_target == noone { // If there isn't a beam target
				// 			beam_list = [] // Clear beam list each frame to prevent duplicates
				// 			switch(spr_dir){	// Weapon can't be aimed past your head or behind you
				// 				case -1:
				// 					weapon_aim = clamp(weapon_aim, 90, 270);
				// 					break;
				// 				case 1:
				// 					if weapon_aim >= 90 && weapon_aim <= 180 {	weapon_aim = 90;	}
				// 					if weapon_aim <= 270 && weapon_aim >= 180 {	weapon_aim = 270;	}
				// 					break;
				// 				break;
	   //                 	}
	   //             		weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)); // X location of the start of the beam
				// 			weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)); // Y location of the start of the beam
				// 			beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim)); // X location of the end of the beam
				// 			beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim)); // Y location of the end of the beam
	   //                 	// switch(spr_dir) {	// switch direction
	   //                 	// 	case -1:	if (weapon_aim < 90 && weapon_aim >= 0) || (weapon_aim <= 360 && weapon_aim > 270) {spr_dir = 1;} break;
	   //                 	// 	case 1:		if weapon_aim > 90 && weapon_aim < 270 {spr_dir = -1;}	break;
	   //                 	// }
				// 			with oPlayer { // Scan players
				// 				if (player != other.player && get_player_team(player) != get_player_team(other.player)) {	// If not me and not on my team
				// 					var b_dist = point_distance(x, y - (char_height/2), other.weapon_x, other.weapon_y);		// Document enemy distance from weapon
				// 					//var b_dist = distance_to_point(other.weapon_x, other.weapon_y);
				// 					if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, self, false, false) && b_dist < other.beam_max_range { // && b_dist > other.arm_offset_y
				// 						if array_find_index(other.beam_list, b_dist) == -1 {	// If not in the list
				// 							array_push(other.beam_list, b_dist);		// Add to the list of people the beam can hit
				// 						}
				// 					}
				// 				}
				// 			}
				// 			if array_length(beam_list) > 0 {	// If there are eligible targets
	   //         				for (i = 0; i < array_length(beam_list); i++;) {	// Descend through list of eligible targets
	   //         					array_sort(beam_list, true);	// Sort list by distance
	   //         				}
	   //         				with oPlayer {
	   //         					if player != other.player && get_player_team(player) != get_player_team(other.player) {
	   //         						if collision_line(other.weapon_x, other.weapon_y, other.beam_x_max, other.beam_y_max, hurtboxID, false, false) {
	   //         				 			if point_distance(x, y - (char_height/2), other.weapon_x, other.weapon_y) == other.beam_list[0] { // If distance between the start of the beam and the midline of the enemy match
	   //         				 			// if distance_to_point(other.weapon_x, other.weapon_y) == other.beam_list[0] {
	   //         								other.beam_target = id;
	   //         							}
	   //         						}
	   //         					}
	   //         				}
	   //         			}
	   //         			else {
	   //         				beam_length = beam_preview_range;	// If no one in range, set beam length to preview
	   //         			}
	   //         			if charge > 0 { charge -= charge_decay; }
	   //         			clamp(charge, 0, charge_max)
	   //         			beam_chip = 0;
	   //         			beam_length = beam_preview_range;
	            			
	   //         			beam_x = x - spr_dir*arm_offset_x + round((beam_offset + beam_length)*dcos(weapon_aim));		// Finds the point on the circle where the x coordinate of the tip would be
				// 			beam_y = y - arm_offset_y - round((beam_offset + beam_length)*dsin(weapon_aim));		// Finds the point on the circle where the y coordinate of the tip would be
	   //         		}
	   //         		else { // If there is a beam target
	   //         			beam_list = [];
	   //         			weapon_x = x - spr_dir*arm_offset_x + round((beam_offset)*dcos(weapon_aim)); // X location of the start of the beam
				// 			weapon_y = y - arm_offset_y - round((beam_offset)*dsin(weapon_aim)); // Y location of the start of the beam
				// 			beam_x_max = x - spr_dir*arm_offset_x + round((beam_offset + beam_max_range)*dcos(weapon_aim)); // X location of the end of the beam
				// 			beam_y_max = y - arm_offset_y - round((beam_offset + beam_max_range)*dsin(weapon_aim)); // Y location of the end of the beam
	   //         			with beam_target {
	   //         			 	if other.beam_length > other.beam_max_range || (invincible == true || state == PS_AIR_DODGE || state == PS_SPAWN || state == PS_DEAD || state == PS_RESPAWN || state == PS_ROLL_BACKWARD || state == PS_ROLL_FORWARD || state == PS_WALL_TECH) { //If target is inside the weapon, out of range, or unable to hit
	   //         					other.beam_target = noone;
	   //         					other.beam_chip = 0;
	   //         					other.weapon_aim = (90*(1-other.spr_dir)); //other.beam_length <= other.arm_offset_y ||
	   //         			 	}
	   //         			 	else {
	   //         			 		if (other.charge < other.charge_max) {		// If not at max charge
	   //         						other.charge += min(other.charge_max - other.charge, 1);	// Charge beam
	   //         						other.charge = clamp(other.charge, 0, other.charge_max);
	   //     						}
	   //         			 		other.beam_chip++;
	   //         			 		other.beam_x = x;
	   //         			 		other.beam_y = y - (char_height/2);
	   //         			 		other.beam_length = point_distance(other.weapon_x, other.weapon_y, other.beam_x, other.beam_y);
	   //         			 		// other.weapon_aim = point_direction(other.weapon_x, other.weapon_y, other.beam_x, other.beam_y);
	   //         			 		other.weapon_aim = point_direction(other.x - other.spr_dir*other.arm_offset_x, other.y-other.arm_offset_y, other.beam_x, other.beam_y);
	   //         			 		if other.weapon_aim > 90 && other.weapon_aim < 270 {other.spr_dir = -1;}
	   //         			 		if other.weapon_aim < 90 || other.weapon_aim > 270 {other.spr_dir = 1;}
	   // 							}
	   //         			}
	   //         			if beam_chip >= beam_chip_threshold {
	   //         			 	take_damage(beam_target.player, player, 1);
	   //         			 	beam_chip = 0;
	   //         			}
				// 		}
				// 		// if beam_target == noone {	beam_length = beam_preview_range;	}	// overwrite and set to preview
						
	   //         	}
	   //             else {
	   //             	window = 3;
	   //             	window_timer = 0;
	   //             }
	            
				// 	// Auto-lock charges
	   //             if (charge < charge_2) { beam_chip_threshold = beam_chip_1; }
				// 	if (charge >= charge_2 && charge < charge_3) { beam_chip_threshold = beam_chip_2; }
				// 	if (charge >= charge_3 ) { beam_chip_threshold = beam_chip_3; }
	   //         	break;
	   //         case 3:
	   //         	beam_target = noone;
	   //             aim_speed = 0; // reset aim speed
	   //             weapon_aim = (90*(1-spr_dir)); // set weapon aim to directly in front of you
				// 	beam_length = 0; //set to 0 to avoid visual glitches such as the beam extending pat targets
	   //             beam_list = [];
	   //             break;
	   //     }
	   //     break;
	   // }
	case AT_DSPECIAL :	// Turrets
    	var new_turret = noone; // Null instance id.
        switch(window) {
        	case 1 :
        		if window_timer == 1 { // Only execute on first frame.
        			if has_rune_more_turrets {
        				turrets = deployable_destroy(turrets, turrets[0]); // Destroy oldest turret, if possible.
        			}
        			else {
    					turrets = deployable_destroy_all(turrets);
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
	            		new_turret.aim_range = new_turret.is_weak_turret ? 32*5 : 32*8;
	            		new_turret.health_max = new_turret.is_weak_turret ? 16 : 64;
	            		new_turret.lifetime = new_turret.is_weak_turret ? turret_rate*2 : turret_rate;
	            		new_turret.chip_damage = new_turret.is_healing ? -1 : 1;
	            		switch new_turret.is_weak_turret {
							case true:
								new_turret.chip_threshold = new_turret.is_healing ? 40 : 20;
								break;
							case false:
								new_turret.chip_threshold = new_turret.is_healing ? 20 : 10;
								break;
						}
	        			turret_charges--;
	                	move_cooldown[AT_DSPECIAL] = 4; //Cooldown before placing next turret
	                	turret_timer += turret_rate;
            		}
            		else {	print_debug("ERROR: Failed to create sentry turret!");	}
			    }
                break;
		}
		break;
        
    case AT_FSPECIAL :	// Barrier
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
                	// reset_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_VSPEED);
                	// reset_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED);
                	// reset_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME);
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
		var orb_type = 1;
		
		if special_down {
			if has_rune_orb_aiming {
				// Set aim speed.
				var v_dir = up_down - down_down;
				if window != 4	{ aim_speed += aim_accel * spr_dir * v_dir; }	// Aiming disabled during release window to improve accuracy.
				if aim_speed != 0 && v_dir == 0 { aim_speed *= aim_decel; }		// Decelerate if not aiming.
				aim_speed = clamp(aim_speed, -max_aim_speed, max_aim_speed);	// Aim speed doesn't go past max speed
				
				// Set weapon aim angle.
				weapon_aim += aim_speed;	// Weapon aim is modified by aim speed/acceleration
				weapon_aim = (weapon_aim >= 360) ? 0 : weapon_aim;	// Resets aim if you go past 360, otherwise the same
				weapon_aim = (weapon_aim < 0) ? 360 : weapon_aim;	// Resets aim if you go below 0, otherwise the same
				weapon_aim = clamp(weapon_aim, 0, 360);		// Closes degree range
				
				// Limit angle to prevent going behind you.
				switch(spr_dir) {
					case -1:
						weapon_aim = clamp(weapon_aim, 90, 270);
						break;
					case 1:
						if weapon_aim > 90 && weapon_aim < 180 {	weapon_aim = 90;	}
						if weapon_aim > 180 && weapon_aim < 270 {	weapon_aim = 270;	}
						break;
				}
				
				// Set orb speed.
				var rounded_weapon_aim = round(weapon_aim);
				aim_cos = dcos(rounded_weapon_aim);
				aim_sin =  dsin(rounded_weapon_aim);
			}
            // Set the starting position of the orb.
        	weapon_x = x - spr_dir * arm_offset_x + beam_offset * dcos(weapon_aim);	
			weapon_y = y - arm_offset_y - beam_offset * dsin(weapon_aim);
		}
		else {
			aim_speed = 0;
		}
		
        switch(window) {
			case 1:
				// Reset variables.
				aim_speed = 0;
				weapon_aim = 90 * (1-spr_dir); // Reset aim to directly in front of you. 0 or 270.
				aim_cos = spr_dir;
				aim_sin = 0;
				break;
			case 2:
				// Reload if thee's no ammo.
				if (ammo <= 0) {	set_attack(AT_EXTRA_1);	}		
                break;
            case 3:
				// Cancel charging
				if !special_down || state_timer > 16 {
					// Re-disable orbs.
					reset_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME);
					reset_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME);
					
					// Reset their speed.
					set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_HSPEED, mini_orb_speed);
					set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_VSPEED, 0);
					set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_HSPEED, big_orb_speed);
					set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_VSPEED, 0);
					
					// Enable correct orb.
					if state_timer >= 16 {	orb_type = 2;	} 
					set_hitbox_value(AT_NSPECIAL, orb_type, HG_WINDOW_CREATION_FRAME, 0);
					
					// Set the orb speed according to weapon aim angle.
					var new_speed = orb_type == 1 ? mini_orb_speed : big_orb_speed;
					var new_hsp = new_speed * aim_cos * spr_dir;
					set_hitbox_value(AT_NSPECIAL, orb_type, HG_PROJECTILE_HSPEED, new_hsp);
					var new_vsp = -new_speed * aim_sin;
					set_hitbox_value(AT_NSPECIAL, orb_type, HG_PROJECTILE_VSPEED, new_vsp);
					
					// Set the starting position of the orb.
					var starting_position_x = spr_dir * beam_offset * aim_cos - arm_offset_x;
					set_hitbox_value(AT_NSPECIAL, orb_type, HG_HITBOX_X, starting_position_x);
					var starting_position_y = -beam_offset * aim_sin - arm_offset_y;
					set_hitbox_value(AT_NSPECIAL, orb_type, HG_HITBOX_Y, starting_position_y);
					
					// Release orb.
					window = 4;
					window_timer = 0;
					
					// Consume ammo if possible.
					var new_cost = orb_type == 1 ? mini_orb_cost : big_orb_cost;
					if ammo < new_cost {
						set_attack(AT_EXTRA_1);	// Reload.
					}
					else {
						ammo -= new_cost;	// Subtract required ammo.
					}
				}
                break;
            case 4:
				// sound_stop(sound_get("orb charging 1"));
				
				var last_frame = get_window_value(AT_NSPECIAL, 4, AG_WINDOW_LENGTH) - 1;
				if window_timer == last_frame && special_down {
					window = 2; // Restart charging phase for next orb.
					window_timer = 0;
					state_timer = 0;
				}
				break;
        }
        break;
    
    case AT_USPECIAL:
    	var tp_entrance = noone;
    	var tp_exit = noone;
        switch(window) {
            case 1:	// Startup
            	if window_timer == 1 { // Only execute on first frame.
        			tp_entrance = teleporters[0];
        			tp_exit = teleporters[1];
            	
            		// If teleporters exist...
            		if instance_exists(tp_entrance) || instance_exists(tp_exit) {
            			tp_timer = tp_rate; // Add time to cooldown timer.
            			deployable_destroy_all(teleporters);
            		}
            	}
            	if window_timer == 6 && tp_timer <= 0 { // If teleporters are not on cooldown...
                	if !instance_exists(tp_entrance) { // Create a preview of the entrance.
                		tp_entrance = deployable_create(teleporters, "obj_article2", x, y);
                    	// tp_entrance.type = "entrance";
                	}
                    if !instance_exists(tp_exit) { // Create a preview of the exit.
                    	var x_offset = 64 *  spr_dir;
                    	tp_exit = deployable_create(teleporters, "obj_article2", x + x_offset, y);
                    	// tp_exit.type = "exit";
                    } 
                    if instance_exists(tp_entrance) && instance_exists(tp_exit) {
                    	sound_play(sound_get("preview"));
                	} 
                	else {
                		move_cooldown[AT_USPECIAL] = 4;	// Cancel if you can't create teleporters.
                	}
            	}
            	break;
            case 2:	// Preview placement
        		if !special_down && state_timer > 20 {	// If special button released...
            		window = 3;	// Switch to next attack window.
            		window_timer = 0;
                }
                break;
            case 3:	// Place and deploy
            	if window_timer == 1 { // Only execute on first frame.
            		// If teleporters are placed, grounded, and not on cooldown...
	            	if tp_timer <= 0
            		&& instance_exists(tp_entrance)
            		&& !tp_entrance.free
            		&& instance_exists(tp_exit)
            		&& !tp_exit.free
            		{
            			tp_entrance.state = 0; // Deploy entrance.
						tp_entrance.damage_cd = 0; // End invulnerability.
            			tp_exit.state = 0; // Deploy exit.
						tp_exit.damage_cd = 0; // End invulnerability.
						sound_play(sound_get("teleporter deployment 2"));
            		}
	            	else {
	            		deployable_destroy_all(teleporters);
	            	}
            	}
        		break;
        }
        break;
}


// Movement while attacking
if (attack == AT_NSPECIAL && !has_rune_orb_aiming)	// If firing orbs without the ability to aim...
|| (attack == AT_JAB && has_rune_beam_lock_on )		// If firing lock-on beam...
|| attack == AT_EXTRA_2		// If placing ultimate...
{
	draw_indicator = false;		// Hide indicator while aiming.
	
    // Allow single jump.
    if jump_pressed && !free {
    	clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
    }
	
	// Allow walking.
    if right_down || left_down {
    	// Set movement direction.
    	var h_dir = right_down - left_down;
    	
    	// Change direction during ultimate.
		if attack == AT_EXTRA_2 {	spr_dir = h_dir; }
	
		// Set acceleration.
		var new_accel = free ? air_accel : walk_accel;
    	hsp += (1 + new_accel) * h_dir;
    	
    	// Set max horizontal speed.
    	var new_max_hsp = free ? air_max_speed : walk_speed;
    	hsp = clamp(hsp, -new_max_hsp, new_max_hsp);
    } 
    else {
    	// Set friction.
    	var new_friction = free ? air_friction : ground_friction;
    	hsp *= new_friction;
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


