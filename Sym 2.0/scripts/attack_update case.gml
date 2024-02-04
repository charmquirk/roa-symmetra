// attack_update

//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

switch(attack) {
    case AT_JAB :
        switch(window) {
            case 1:
                // Resets the variables and aim
                weapon_aim = 0;
                charge = 0;
                break;
            case 2:
            case 3:
            case 4:
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
                } 
                break;
            case 5:
                weapon_aim = 0;
                break;
        }
        // Beam Charges after doing damage
        if (has_hit && !was_parried && charge < 240) {
            charge += 1;
        }      
        
        // Manually coded inputs
        fall_through = down_down;
    
        if (jump_pressed && !free) {
		    clear_button_buffer(PC_JUMP_PRESSED);
		    vsp = -jump_speed;
		    sound_play(asset_get("sfx_jumpground"));
	    }

        
        if (left_down) {
            hsp = -walk_speed*3/4;
        }
        if (right_down) {
            hsp = walk_speed*3/4;
        }
        break;

    case AT_NSPECIAL :
        switch(window) {
            case 2:
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
                break;
        }
    


    case AT_USPECIAL:
        switch(window) {
            case 2:
                if (!special_down) {
                        window = 3;
                        window_timer = 0;
                }
                else {
                    if (!instance_exists(teleporter_preview)) {
                        teleporter_preview = instance_create(x -32*spr_dir,y-62,"obj_article1");
                        teleporter_preview.type = "teleporter_preview";
                    }
                }
                break;
            case 3:
                if (window_timer == 0) { 
                    instance_destroy(teleporter_preview);
                    sound_play(asset_get("mfx_back"));
                }
        		if (window == 3 && window_timer == 0) { 
        			instance_destroy(teleporter_preview);
            		sound_play(asset_get("mfx_back"));
        		}
        		break;
        }
    
    case AT_DSPECIAL :
        switch(window) {
        	case 1 :
        		if (move_cooldown[AT_DSPECIAL] > 0) {
					attack = AT_DSPECIAL_2;
	    		}
            case 2:
                if (!special_down) {
                    switch(window) {
                        case 2:
                            window = 3;
                            window_timer = 0;
                            break;
                	}
                }
                else {
			        if (!instance_exists(solid_preview) && solids_available > 0 && window_timer == 0) { 
				        solid_preview = instance_create(x - 64, y, "obj_article1");
        		        solid_preview.type = "solid_preview";
                        sound_play(sound_get("preview"));
			        }
		        }
                break;
            case 3:
                if (window_timer == 0) {
                    if (solids_available > 0) {
                        instance_destroy(solid_preview);
        	            solid_platform = instance_create(x - 64, y, "obj_article_solid");
        	            sound_play(sound_get("shield bloat 1"));
                        solids_available -= 1;
        	            solid_timer += solid_rate;
        	            move_cooldown[AT_DSPECIAL] = 24;
                    }
                }
                break;
		}
		break;
	break;
}