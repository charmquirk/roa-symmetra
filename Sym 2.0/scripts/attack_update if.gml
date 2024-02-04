// attack_update

//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

// Solid
//var max_platforms = 2
//var platforms = max_platforms

if (attack == AT_USPECIAL){
    if (window == 2) {
        can_move = true
        if (!special_down) {
            switch(window) {
                case 2:
                    window = 3;
                    window_timer = 0;
                    break;
            }
        }
        else {
            if (!instance_exists(teleporter_preview)) {
                teleporter_preview = instance_create(x -32*spr_dir,y-62,"obj_article1");
                teleporter_preview.type = "teleporter_preview";
            }
        }
    }
    if (window == 3 && window_timer == 0) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
    	instance_destroy(teleporter_preview);
        sound_play(asset_get("mfx_back"));
    }
    
    // Manually coded inputs
    fall_through = down_down;
    
    if (jump_pressed && !free) {
		clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
	}
	
    if (left_down) {
		spr_dir = -1;
		hsp = walk_speed * spr_dir;
	}
    if (right_down) {
		spr_dir = 1;
		hsp = walk_speed * spr_dir;
	}
    move_cooldown[AT_USPECIAL] = 60;
}


if (attack == AT_JAB) {
   
    // Resets the variables and aim
    if (window == 1){
        weapon_aim = 0;
        charge = 0;
    }
    
    // Checks to see if you released the button before the timer ends.
    if (window > 1 && window != 5){
    	
    	
        
        // Shooting without aiming by releasing the button early.
        if (!attack_down && state_timer > 12){
            window = 5;  
            window_timer = 0;
        }
        // Shooting with aiming by holding down the button.
        else {
            
            // Move to level 2
            if (charge >=120 && charge < 240) {
                window = 3;
            }
            // Move to level 3
            if (charge >=240 ) {
               window = 4;
            }
            
            // Turn sprite
                // Facing Right
                if (spr_dir == 1) {
                    if (state_timer > 6 && down_down && weapon_aim > -90) {
                        weapon_aim -= 3;
                    }
                    if (state_timer > 6 && up_down && weapon_aim < 90) {
                        weapon_aim += 3;
                    }
                }
                // Facing Left
                if (spr_dir == -1) {
                    if (state_timer > 6 && down_down && weapon_aim < 90) {
                        weapon_aim += 3;
                    }
                    if (state_timer > 6 && up_down && weapon_aim > -90) {
                        weapon_aim -= 3;
                    }
                }

            
            // Move
            //if (state_timer > 6 && right_down) {
                //vsp -= walk_accel * walk_accel;
                //vsp = clamp(vsp, 0, walk_speed)
                
            }
            
        }
    // Beam Charges after doing damage
    if (has_hit && !was_parried && charge <=239) {
        charge += 1;
    }
    
    // Manually coded inputs
    fall_through = down_down;
    
    if (jump_pressed && !free) {
		clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
	}

    if (right_down || left_down) {
        if (left_down) {
            hsp = -walk_speed*3/4;
            //hsp = max(-walk_speed, hsp);
        }
        if (right_down) {
            hsp = walk_speed*3/4;
            //hsp = min(walk_speed, hsp);
        }
        
        // switch(spr_dir) {
        //     case 1 :
        //         if (left_down) {
        //             hsp = walk_speed * spr_dir;
        //         }
        //         if (right_down) {
        //             hsp = walk_speed * spr_dir;
        //         }
        //     case -1 :
        //         if (left_down) {
        //             hsp = walk_speed * spr_dir;
        //         }
        //         if (right_down) {
        //             hsp = walk_speed * spr_dir;
        //         }
	}
	if (window == 5) {
		  weapon_aim = 0;
	}
}


if (attack == AT_DSPECIAL) {
	if (move_cooldown[AT_DSPECIAL] > 0) {
		attack = AT_DSPECIAL_2;
	}
	if (window == 2) {
        if (!special_down) {
            switch(window) {
                case 2:
                    window = 3;
                    window_timer = 0;
                    break;
            }
		}
		else {
			if (!instance_exists(solid_preview) && solids_available > 0) {
				solid_preview = instance_create(x - 64, y, "obj_article1");
        		solid_preview.type = "solid_preview";
			}
		}
	}
	
    if (window == 3 && window_timer == 0) { // WARN: Possible repetition during hitpause. Consider using window_time_is(frame) https://rivalslib.com/assistant/function_library/attacks/window_time_is.html
        instance_destroy(solid_preview);
        if (solids_available > 0) {
        	solid_platform = instance_create(x - 64, y, "obj_article_solid");
        	solids_available -= 1;
        	solid_timer += solid_rate;
        	move_cooldown[AT_DSPECIAL] = 24;
        }
        
    }
}


if (attack == AT_NSPECIAL) {
    
    // Resets the variables and aim
    if (window == 1){
        //scope_fast = false;
        scope_aim = 0;
    }
    
    // Checks to see if you released the button before the timer ends.
    if (window == 2){
        // Shooting without aiming by releasing the button early.
        if (!special_down){
            
            // Uncharged
            if (state_timer < 16) {
                set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);
                set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 3);
                move_cooldown[AT_NSPECIAL] = 2;
            }
            // Charged
            else {
                set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 3);
                set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99);
                move_cooldown[AT_NSPECIAL] = 12;
            }
            
            window = 3;  
            window_timer = 0;
        }
        // Shooting with aiming by holding down the button.
        else {
            if (state_timer > 120){
                switch(window) {
                    case 2:
                        set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 3);
                        set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99);
                        window = 3;  
                        window_timer = 0;
                        break;
                }
            }
        // When I used an if statement it wouldn't process in order. The window timer
        // would reset but the window wouldn't change. Using a switch fixes this.
        }
    }
    
    // Manually coded inputs
    fall_through = down_down;
    
    if (jump_pressed && !free) {
		clear_button_buffer(PC_JUMP_PRESSED);
		vsp = -jump_speed;
		sound_play(asset_get("sfx_jumpground"));
	}
    
//     if (left_down || right_down) {
//         switch(_down) {
//             case left_down :
//                 spr_dir = -1;
//                 break;
//             case right_down :
//                 spr_dir = 1;
//                 break;
//         }
// 		hsp = walk_speed * spr_dir;
// 	}
}


if (attack == AT_USTRONG) {
    
    //if (window == 2) {
    //    if (state_timer < 12 && !up_strong_pressed) {
            // Skip dancing and go to active hitboxes
    //        switch (window) {
    //            case 2:
    //                window = 3
   //         }
    //    }
   // }
}

// #region vvv LIBRARY DEFINES AND MACROS vvv
// DANGER File below this point will be overwritten! Generated defines and macros below.
// Write NO-INJECT in a comment above this area to disable injection.
#define window_time_is(frame) // Version 0
    // Returns if the current window_timer matches the frame AND the attack is not in hitpause
    return window_timer == frame and !hitpause
// DANGER: Write your code ABOVE the LIBRARY DEFINES AND MACROS header or it will be overwritten!
// #endregion