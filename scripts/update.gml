//update.gml
//Ultimate charge
if has_rune("L") && state != PS_DEAD  && state != PS_SPAWN && state != PS_RESPAWN && ult_charge < ult_cost && !instance_exists(teleporter_ultimate) { //if not dead or spawning //
	ult_charge++;//passively generate ultimate charge
}


if has_rune("A") && (state == PS_AIR_DODGE || state == PS_WAVELAND){draw_indicator = false;}//invisible = true; init_shader();
// else {  outline_color = [0,0,0];}outline_color = [sym_r0,sym_g0,sym_b0];


if (barrier_timer > 0) {  barrier_timer--;  }       // Barrier cooldown system
if (("tp_timer" in self) && tp_timer > 0) {  tp_timer--;  }     // Teleporter cooldown system
if (("turret_timer" in self) && turret_timer > 0) { turret_timer--; }     // Turret cooldown system


// Regenerate charges for turrets if max charges hasn't been reached
if ("turret_charges" in self) && (turret_charges < max_turrets) {
	if (max_turrets > 1) {
    	if (turret_timer == turret_rate*(max_turrets-turret_charges-1)){ //if timer ends
 	    	turret_charges++; //create a charge
 		}
   
    	// If the turret timer is less than required to meet max turrets, increase timer
		if (turret_timer < turret_rate*(max_turrets-turret_charges-1)) {
        	turret_timer += turret_rate;
    	}
	}
	else {
		if (turret_timer == 0 && !instance_exists(sentry)){ //if timer ends
 	    	turret_charges++; //create a charge
 		}
	}
}

if !has_rune("E") { //if you can have multiple turrets
// Check for empty spaces in turret array
if ("turrets" in self) && array_length(turrets) > 0 {
    for (i = 0; i < array_length(turrets); i++;) {  //Start at first index and oldest turret
        if turrets[i] == noone && i < array_length(turrets) {     // If current position empty
            if array_length(turrets) == 1 {         // If array only has one empty slot
                turrets = [];   // Reset array
                break;
            }
            if array_length(turrets) > 1 {      // If array has many turrets
                if i == 0 || i == (array_length(turrets) - 1)  {      // If on either end of the array
                    if i == 0 {         // If first in array and oldest turret
                        turrets = array_slice(turrets, 1, array_length(turrets)-1); // Shorten and cut out first index.
                        i--;    //Restart next iteration at the same position which will have the new value
                    }
                    if i == (array_length(turrets) - 1) {     // If last in array and most recent turret
                        turrets = array_slice(turrets, 0, i);   // Shorten and cut out last index.
                    }
                }
                else {      // If in the middle of the array
                    if turrets[i+1] != noone && (i+1) < array_length(turrets) {    // If there is a next value in the array
                        turrets[i] = turrets[i+1];
                        turrets[i+1] = noone;
                        i--;    //Restart next iteration at the same position which will have the new value
                    }
                }
            }
        }
    }    
}

// If maximum turrets are placed, destroy the oldest turret
if ("turrets" in self) && array_length(turrets) > max_turrets {
    for (k = 0; k < array_length(turrets); k++;) {
        if k < (array_length(turrets) - max_turrets) {
            var cur_tur = turrets[k];
            if cur_tur != noone {
                cur_tur.state = 2;     // Delete turret
                cur_tur.state_timer = 0;
            }
            else {
                // turrets = array_slice(turrets, 1, array_length(turrets) - 1);     // Cut first turret out of the array
                // break;
            }
        }
    }
}
}


// Not using beam or you haven't been targeting anyone
if (attack != AT_JAB || attack == AT_JAB && !attack_down || beam_target == noone && window_timer > 2 ) {
    //get_window_value(AT_JAB, 2, AG_WINDOW_LENGTH)
    beam_target = noone;
    // beam_length = 0;
    beam_timer = 0;
}

if beam_timer > 0 && beam_length > beam_range {
    beam_timer--;
}

if ("beam_lock_time" in self) { clamp(beam_timer, 0, beam_lock_time);}



if attack == AT_USPECIAL {
	if instance_exists(teleporter_exit) && teleporter_exit.state = -1 {
		
		// var tp_yrange = 256;
		// var tp_height = 76;
		// var tp_nxp = teleporter_exit.x - teleporter_exit.tp_xv;     //next position for tp
		// var collide_solid = collision_line(tp_nxp, teleporter_exit.y-tp_yrange, tp_nxp, teleporter_exit.y+tp_yrange, asset_get("par_block"), false, true);	// If solid at projected location
		// var collide_plat = collision_line(tp_nxp, teleporter_exit.y-tp_yrange, tp_nxp, teleporter_exit.y+tp_yrange, asset_get("par_jumpthrough"), false, true);		// If solid at projected location
		
		if (left_down || right_down) {	//If trying to move and next projected location is available		 && place_free(tp_nxp,teleporter_exit.y) && place_free(tp_nxp,teleporter_exit.y-tp_height) 
			if left_down && !right_down {	teleporter_exit.tp_xv -= teleporter_exit.accel;	}
			if right_down && !left_down {	teleporter_exit.tp_xv += teleporter_exit.accel; }
			teleporter_exit.tp_xv = clamp(teleporter_exit.tp_xv, -teleporter_exit.max_hsp, teleporter_exit.max_hsp);
		}
		else {
			if teleporter_exit.tp_xv != 0 {	teleporter_exit.tp_xv = teleporter_exit.tp_xv * teleporter_exit.accel;	}
		}
		teleporter_exit.x += teleporter_exit.tp_xv;
		teleporter_exit.x = round(teleporter_exit.x);
		
		// if (collide_plat || collide_solid) {
		// 	teleporter_exit.x = teleporter_exit.tp_x;
		// }
		
		
		
		
		
		if teleporter_exit.x > x { spr_dir = 1; }
		else { spr_dir = -1; }
		
		// Move the exit vertically
		if (up_down || down_down ) {
			if up_down && !down_down {
				teleporter_exit.can_be_grounded = true;
				teleporter_exit.tp_yv -= teleporter_exit.accel;	
			}
			if (down_down && !up_down) {
				teleporter_exit.can_be_grounded = false;
				teleporter_exit.tp_yv += teleporter_exit.accel;	
    		}
		}
    	else {
    		if !right_down && !left_down { teleporter_exit.vsp = teleporter_exit.grav; }	//gravity
    		if teleporter_exit.tp_yv != 0 {	teleporter_exit.tp_yv = teleporter_exit.tp_yv * teleporter_exit.accel;	}
		}
		if teleporter_exit.tp_yv != 0 {teleporter_exit.vsp = clamp(teleporter_exit.vsp, -teleporter_exit.max_vsp, teleporter_exit.max_vsp);}
		teleporter_exit.y += teleporter_exit.tp_yv;
		teleporter_exit.y = round(teleporter_exit.y);
		// if (up_pressed || down_pressed ) {
		// 	if up_pressed {
			
		// 		teleporter_exit.can_be_grounded = true;
				
		// 		if teleporter_exit.free != true {
		// 			teleporter_exit.vsp = -256;
		// 		}
				
		// 	}
		// 	if (down_pressed) {
		// 		teleporter_exit.vsp++;
		// 		teleporter_exit.vsp = clamp(teleporter_exit.vsp, -teleporter_exit.max_vsp, teleporter_exit.max_vsp);
		// 		teleporter_exit.can_be_grounded = false;
  //  		}
		// }
  //  	else {
  //  		// teleporter_exit.vsp = teleporter_exit.max_vsp;		//gravity
		// }
		if jump_pressed && !free {
    		clear_button_buffer(PC_JUMP_PRESSED);
			vsp = -jump_speed;
			sound_play(asset_get("sfx_jumpground"));
    	}
	}
}




// Teleporting yourself
if (("tp_timer" in self) && ("tp_tp_timer" in self) && tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,teleporter_entrance) && teleporter_entrance.state = 0) {
        tp_tp_timer = tp_interval;
        x = teleporter_exit.x;
        y = teleporter_exit.y;
        move_cooldown[AT_TAUNT] = tp_interval;
        outline_color = [sym_r1,sym_g1,sym_b1];
        init_shader();
}
if (("tp_timer" in self) && ("tp_tp_timer" in self) && tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,teleporter_exit) && teleporter_exit.state = 0) {
        tp_tp_timer = tp_interval;
        x = teleporter_entrance.x;
        y = teleporter_entrance.y;
        move_cooldown[AT_TAUNT] = tp_interval;
        outline_color = [sym_r1,sym_g1,sym_b1];
        init_shader();
}


with oPlayer {
    if ("tp_tp_timer" in self) && tp_tp_timer > 0 {
        --tp_tp_timer;
    }
    if ("tp_tp_timer" in self) {switch(tp_tp_timer) {
        case 0:
            outline_color = [0,0,0];
            init_shader();
            break;
    }}
    // Teleporting other players only
    if other.player != player {
        if (get_match_setting(SET_TEAMATTACK) == 1 || get_player_team(player) == get_player_team(other.player)) {
    
            // Other players teleporting
            if (tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,other.teleporter_entrance) && other.teleporter_entrance != teleporter_entrance && other.teleporter_entrance.state = 0) {
            // If its not your teleporter, the owner will process it
                tp_tp_timer = tp_interval;
                x = other.teleporter_exit.x;
                y = other.teleporter_exit.y;
                // spawn_hit_fx(x,y,14);
                move_cooldown[AT_TAUNT] = tp_interval;
                outline_color = [other.sym_r1,other.sym_g1,other.sym_b1];
                init_shader();
            }
            if (tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,other.teleporter_exit) && other.teleporter_exit != teleporter_exit && other.teleporter_entrance.state = 0) {
                tp_tp_timer = tp_interval;
                x = other.teleporter_entrance.x;
                y = other.teleporter_entrance.y;
                // spawn_hit_fx(x,y,14);
                move_cooldown[AT_TAUNT] = tp_interval;
                outline_color = [other.sym_r1,other.sym_g1,other.sym_b1];
                init_shader();
            }
        }
    }
}  

// Beam charge decreases if you're doing something else, you're not firing beam, or if your beam isn't hitting anyone.
// if (charge > 0 && attack != AT_JAB || charge > 0 && attack == AT_JAB && has_hit == false || charge > 0 && attack == AT_JAB && attack_down == false) {
// Beam charge decreases if you're doing something else, or you're not firing beam, or you're not targeting anyone and haven't hit anyone
if charge > 0 {
    if (attack != AT_JAB || attack == AT_JAB && attack_down == false || attack == AT_JAB && beam_target == noone) {
        charge -= charge_decay;
    }
}


// Cancel preview attacks
if (state == PS_HITSTUN || state == PS_HITSTUN_LAND || state == PS_TUMBLE || state == PS_PRATFALL || state == PS_PRATLAND || state == PS_FROZEN || state == PS_WRAPPED || state == PS_DEAD) {
    if instance_exists(teleporter_entrance) && teleporter_entrance.state = -1 { instance_destroy(teleporter_entrance); }
    if instance_exists(teleporter_exit) && teleporter_exit.state = -1 { instance_destroy(teleporter_exit); }

    sound_stop(sound_get("orb charging 1"));
}




// Teleporter ultimate
if instance_exists(teleporter_ultimate) { //If teleporter exists and its not yours
if array_length(tp_team) == 0 {	array_push(tp_team, id);}
if array_length(tp_team) > 0 {
	tp_slide_step++;
	// print("Step " + string(tp_slide_step));
	if tp_slide_step >= tp_slide_length {
		tp_slide_step = 0; //reset steps
		tp_slide++; //display next teammate
		// print("Slide " + string(tp_slide));
		
	}
	if tp_slide > array_length(tp_team) -1{ tp_slide = 0; tp_slide_step = 0;} //go back to beginning
	else {tp_subject = tp_team[tp_slide];}
	
	
}
with oPlayer {
	if get_player_team(player) == get_player_team(other.player) { //if on symmetra's team
	
		if (state == PS_RESPAWN && get_player_stocks(player) == 1) || state == PS_DEAD || get_player_stocks(player) == 0 || (player == other.player && get_player_stocks(player) == 1  && teleporter_ultimate.player_id != id) { //if you have one stock left or you are symmetra
			set_player_stocks(player, get_player_stocks(player)+ 1); //add stock, its 2 for sym
		}
		if state == PS_DEAD { //if you have no stocks left
			// set_player_stocks(player, 1); //set it to 1 stock
			set_state(PS_RESPAWN);
		}
		if state == PS_RESPAWN {
			other.tp_slide_step = 0;
			other.tp_slide = array_find_index(other.tp_team,id);
			other.tp_subject = other.tp_team[other.tp_slide];
		}
		if array_length(other.tp_team) > 0 {
			for (n=0; n < array_length(other.tp_team); n++;) { //scan array for dead teammates array_length(other.tp_team)
				// if other.tp_team[n] != noone {
					if other.tp_team[n] == id { break;} //if you are in the array
					else { //if you haven't found yourself yet
						if other.tp_team[n] != id && n == array_length(other.tp_team) -1 { //if scanned entire array and didn't find yourself
						array_push(other.tp_team, id); //add yourself to the array
						}
					}
				// }
				
			}
		}
	
		// }
		//Respawn at the teleporter
		if state == PS_RESPAWN && instance_exists(other.teleporter_ultimate) { x = other.teleporter_ultimate.x; y = other.teleporter_ultimate.y - 16 - char_height/2; outline_color = [other.sym_r0, other.sym_g0, other.sym_b0]; init_shader(); }
	}
}
// Clear empty spaces and reoganize array
if array_length(tp_team) > 0 {
    for (m = 0; m < array_length(tp_team); m++;) {  //Start at first index and oldest turret
        if tp_team[m] == noone {     // If current position empty
            if array_length(tp_team) == 1 {         // If array only has one empty slot
                tp_team = [];   // Reset array
                break;
            }
            if array_length(tp_team) > 1 {      // If array has many tp_team
                if m == 0 || m == (array_length(tp_team) - 1)  {      // If on either end of the array
                    if m == 0 {         // If first in array and oldest turret
                        tp_team = array_slice(tp_team, 1, array_length(tp_team)-1); // Shorten and cut out first index.
                        m--;    //Restart next iteration at the same position which will have the new value
                    }
                    if m == (array_length(tp_team) - 1) {     // If last in array and most recent turret
                        tp_team = array_slice(tp_team, 0, m);   // Shorten and cut out last index.
                    }
                }
                else {      // If in the middle of the array
                    if tp_team[m+1] != noone && (m+1) < array_length(tp_team) {    // If there is a next value in the array
                        tp_team[m] = tp_team[m+1]; //move next position down a slot in the array
                        tp_team[m+1] = noone; //make next position empty
                        m--;    //Restart next iteration at the same position which will have the new value
                    }
                }
            }
        }
        else {
        	if instance_exists(tp_team[m]) {
        		if ("player" in self) && get_player_team(tp_team[m].player) == get_player_team(player) {
        			//nothing
        		}
        		else {
        			tp_team[m] = noone; //erase from array if not a player on team
        		}
        	}
        }
    }    
}
}



// if array_length(tp_team) == 2 {tp_subject = tp_team[0];}

// }



// // Kirby Support
// if swallowed { //Kirby ability script starts here
//     swallowed = 0;
//     //Define any assets kirby might need to grab from YOUR CHARACTER
//     var ability_spr = sprite_get("kirby_ability");
//     var ability_hurt = sprite_get("kirby_ability_hurt");
//     var ability_proj = sprite_get("kirby_orb");
//     var ability_proj_shoot = sound_get("orb shot 2");
//     var ability_proj_hit = asset_get("orb shot 2");
//     var ability_proj_col = sprite_get("orb_col_mask");
//     var ability_icon = sprite_get("kirby_icon"); //Optional
    
//     with enemykirby { //Define AT_EXTRA_3 for Kirby, using your asset variables where necessary in place of sprite_get or sound_get
      
        
//         set_attack_value(AT_EXTRA_3, AG_SPRITE, ability_spr);
//         set_attack_value(AT_EXTRA_3, AG_HURTBOX_SPRITE, ability_hurt);
//         set_attack_value(AT_EXTRA_3, AG_CATEGORY, 2);
//         set_attack_value(AT_EXTRA_3, AG_NUM_WINDOWS, 3);
        
//         //Startup
//         set_window_value(AT_EXTRA_3, 1, AG_WINDOW_TYPE, 0);
//         set_window_value(AT_EXTRA_3, 1, AG_WINDOW_LENGTH, 6);
//         set_window_value(AT_EXTRA_3, 1, AG_WINDOW_ANIM_FRAMES, 3);
//         set_window_value(AT_EXTRA_3, 1, AG_WINDOW_ANIM_FRAME_START, 0);
        
//         //Active

//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_TYPE, 0);
//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_LENGTH, 8);
//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_ANIM_FRAMES, 4);
//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_ANIM_FRAME_START, 3);
//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_HAS_SFX, 1);
//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_SFX, ability_proj_shoot);
//         set_window_value(AT_EXTRA_3, 2, AG_WINDOW_SFX_FRAME, 0);
        
//         //Endlag
//         set_window_value(AT_EXTRA_3, 3, AG_WINDOW_TYPE, 0);
//         set_window_value(AT_EXTRA_3, 3, AG_WINDOW_LENGTH, 2);
//         set_window_value(AT_EXTRA_3, 3, AG_WINDOW_ANIM_FRAMES, 1);
//         set_window_value(AT_EXTRA_3, 3, AG_WINDOW_ANIM_FRAME_START, 7);
        
//         set_num_hitboxes(AT_EXTRA_3, 1);
        
//         set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_TYPE, 2);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_WINDOW, 2);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_WINDOW_CREATION_FRAME, 3);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_LIFETIME, 600);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_X, 24);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_Y, -24);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_WIDTH, 64);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_HEIGHT, 64);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PRIORITY, 3);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_DAMAGE, 12);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_ANGLE, 45);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_BASE_KNOCKBACK, 4);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_KNOCKBACK_SCALING, 0.1);
//         // set_hitbox_value(AT_EXTRA_3, 1, HG_HIT_LOCKOUT, 10);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_BASE_HITPAUSE, 18);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_HITPAUSE_SCALING, 0.8);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_VISUAL_EFFECT, 3);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_HIT_SFX, ability_proj_hit);
        
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_SPRITE, ability_proj);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_MASK, -1);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_COLLISION_SPRITE, ability_proj_col);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_HSPEED, 2);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_WALL_BEHAVIOR, 0);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_GROUND_BEHAVIOR, 0);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_IS_TRANSCENDENT, 1);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_DOES_NOT_REFLECT, 1);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_PARRY_STUN, 1);
//         set_hitbox_value(AT_EXTRA_3, 1, HG_IGNORES_PROJECTILES, 1);
        
        
//     newicon = ability_icon //Optional, replaces the kirby ability icon
//     } //Kirby ability script ends here
// }
// if enemykirby != noone { //if kirby is in a match & has swallowed the character
//     with oPlayer {
//     	if (attack == AT_EXTRA_3 && window == 3) {
//         	move_cooldown[AT_EXTRA_3] = 180;
//     	}
//     }
// }