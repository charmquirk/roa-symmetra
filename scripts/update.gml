//update

// construct cooldown system
if (construct_timer > 0) {
// Count down
    construct_timer--;
}

// Regenerate charges for constructs if max charges hasn't been reached
if (constructs_available < max_constructs) {
    if (construct_timer == construct_rate*(max_constructs-constructs_available-1)){
 	    constructs_available++; 
 	}
   
    // If the construct timer is less than required to meet max constructs, increase timer
    if (construct_timer < construct_rate*(max_constructs-constructs_available-1)) {
        construct_timer += construct_rate;
    }
}


// // Placed construct management / Deletes the last construct
// if array_length(constructs) > max_constructs_placed {
//     for (i = array_length(constructs)-1; i > 0; i--) {
//         if i > max_constructs_placed {
//             constructs[i].state = 1;
//             constructs[i].state_timer = 0;
//             // constructs[i] = noone;
//             // constructs = array_slice(constructs, 0, i-1);
//         }
//     }
// }


// Check for empty spaces
if array_length(constructs) > 0 {
    for (i = 0; i < array_length(constructs); i++;) {  //Start at first index and oldest turret
        if constructs[i] == noone && i < array_length(constructs) {     // If current position empty
            if array_length(constructs) == 1 {         // If array only has one empty slot
                constructs = [];   // Reset array
                break;
            }
            if array_length(constructs) > 1 {      // If array has many constructs
                if i == 0 || i == (array_length(constructs) - 1)  {      // If on either end of the array
                    if i == 0 {         // If first in array and oldest turret
                        constructs = array_slice(constructs, 1, array_length(constructs)-1); // Shorten and cut out first index.
                        i--;    //Restart next iteration at the same position which will have the new value
                    }
                    if i == (array_length(constructs) - 1) {     // If last in array and most recent turret
                        constructs = array_slice(constructs, 0, i);   // Shorten and cut out last index.
                    }
                }
                else {      // If in the middle of the array
                    if constructs[i+1] != noone && (i+1) < array_length(constructs) {    // If there is a next value in the array
                        constructs[i] = constructs[i+1];
                        constructs[i+1] = noone;
                        i--;    //Restart next iteration at the same position which will have the new value
                    }
                }
            }
        }
    }    
}

// If maximum constructs are placed, destroy the oldest construct
if array_length(constructs) > max_constructs_placed -1 {
    for (k = 0; k < array_length(constructs); k++;) {
        if k < (array_length(constructs) - max_constructs_placed) {
            if constructs[k] != noone && array_find_index(constructs, constructs[k]) != -1 {    // if it exists and it is in the array
                constructs[k].state = 1;     // Delete construct
                constructs[k].state_timer = 0;
            }
            else {  // if it doesn't exist and/or it is not in the array
            
                // constructs[k].state = 1;     // Delete construct
                // constructs[k].state_timer = 0;
                // constructs[k] = noone;
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

clamp(beam_timer, 0, beam_lock_time);


// Barrier cooldown system
// if (barrier_timer > 0) {    barrier_timer--; }

// Teleporter cooldown system
if (tp_timer > 0) {
// Count down
    tp_timer--;
    // move_cooldown[AT_USPECIAL] = 2;
}



// // Not using beam or you haven't been targeting anyone
// if (attack != AT_JAB || attack == AT_JAB && !attack_down || beam_target == noone && window_timer > 2 ) {
//     //get_window_value(AT_JAB, 2, AG_WINDOW_LENGTH)
//     beam_target = noone;
//     // beam_length = 0;
//     beam_timer = 0;
// }

if beam_timer > 0 && beam_length > beam_range {
    beam_timer--;
}

clamp(beam_timer, 0, beam_lock_time);

  // beam charge decay
if charge > 0 {  if (attack != AT_FSPECIAL || attack == AT_FSPECIAL && !special_down) { charge -= charge_decay; beam_target = noone;} }


// Invisible airdodge
if (state == PS_AIR_DODGE) {
    draw_indicator = false;
}

// Teleporting youtself
if (tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,teleporter_entrance) && teleporter_entrance.state == 0) {
        tp_tp_timer = tp_interval;
        x = teleporter_exit.x;
        y = teleporter_exit.y+32;
        move_cooldown[AT_TAUNT] = tp_interval;
        outline_color = [sym_r1,sym_g1,sym_b1];
        init_shader();
}
if (tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,teleporter_exit) && teleporter_exit.state == 0) {
        tp_tp_timer = tp_interval;
        x = teleporter_entrance.x;
        y = teleporter_entrance.y+32;
        move_cooldown[AT_TAUNT] = tp_interval;
        outline_color = [sym_r1,sym_g1,sym_b1];
        init_shader();
}


with oPlayer {
    if tp_tp_timer > 0 {
        --tp_tp_timer;
    }
    switch(tp_tp_timer) {
        case 0:
            outline_color = [0,0,0];
            init_shader();
            break;
    }
    // Teleporting other players only
    if other.player != player {
        if (get_match_setting(SET_TEAMATTACK) == 1 || get_player_team(player) == get_player_team(other.player)) {
    
            // Other players teleporting
            if (tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,other.teleporter_entrance) && other.teleporter_entrance != teleporter_entrance && other.teleporter_entrance.state == 0) {
            // If its not your teleporter, the owner will process it
                tp_tp_timer = tp_interval;
                x = other.teleporter_exit.x;
                y = other.teleporter_exit.y+32;
                // spawn_hit_fx(x,y,14);
                move_cooldown[AT_TAUNT] = tp_interval;
                outline_color = [other.sym_r1,other.sym_g1,other.sym_b1];
                init_shader();
            }
            if (tp_tp_timer <= 0 && taunt_pressed && instance_place(x,y,other.teleporter_exit) && other.teleporter_exit != teleporter_exit && other.teleporter_exit.state == 0) {
                tp_tp_timer = tp_interval;
                x = other.teleporter_entrance.x;
                y = other.teleporter_entrance.y+32;
                // spawn_hit_fx(x,y,14);
                move_cooldown[AT_TAUNT] = tp_interval;
                outline_color = [other.sym_r1,other.sym_g1,other.sym_b1];
                init_shader();
            }
        }
    }
}    
    // clear_button_buffer(PC_TAUNT_PRESSED);
    // switch(attack) {
    //     case AT_TAUNT:
    //     set_attack(47);
    //         // set_state(PS_IDLE);
    //         // state = PS_IDLE;
    //         break;
    // }
// }

// if attack != AT_USPECIAL && teleporter_entrance.state == -1 {
//     teleporter_entrance.state = 1;
//     teleporter_exit.state = 1;
//     // instance_destroy(teleporter_entrance);
//     // instance_destroy(teleporter_exit);
// }

// Cancel preview attacks
if (state == PS_HITSTUN || state == PS_HITSTUN_LAND || state == PS_TUMBLE || state == PS_PRATFALL || state == PS_PRATLAND || state == PS_FROZEN || state == PS_WRAPPED || state == PS_DEAD) {
    if instance_exists(teleporter_entrance) && teleporter_entrance.state == -1 {    teleporter_entrance.state = 1;}
    if instance_exists(teleporter_exit) && teleporter_exit.state == -1 {    teleporter_exit.state = 1;}
    
    // instance_destroy(constructs);
    sound_stop(sound_get("orb charging 1"));
}


// Kirby Support
if swallowed { //Kirby ability script starts here
    swallowed = 0;
    //Define any assets kirby might need to grab from YOUR CHARACTER
    var ability_spr = sprite_get("kirby_ability");
    var ability_hurt = sprite_get("kirby_ability_hurt");
    var ability_proj = sprite_get("kirby_orb");
    var ability_proj_shoot = sound_get("orb shot 2");
    var ability_proj_hit = asset_get("orb shot 2");
    var ability_proj_col = sprite_get("orb_col_mask");
    var ability_icon = sprite_get("kirby_icon"); //Optional
    
    with enemykirby { //Define AT_EXTRA_3 for Kirby, using your asset variables where necessary in place of sprite_get or sound_get
      
        
        set_attack_value(AT_EXTRA_3, AG_SPRITE, ability_spr);
        set_attack_value(AT_EXTRA_3, AG_HURTBOX_SPRITE, ability_hurt);
        set_attack_value(AT_EXTRA_3, AG_CATEGORY, 2);
        set_attack_value(AT_EXTRA_3, AG_NUM_WINDOWS, 3);
        
        //Startup
        set_window_value(AT_EXTRA_3, 1, AG_WINDOW_TYPE, 0);
        set_window_value(AT_EXTRA_3, 1, AG_WINDOW_LENGTH, 6);
        set_window_value(AT_EXTRA_3, 1, AG_WINDOW_ANIM_FRAMES, 3);
        set_window_value(AT_EXTRA_3, 1, AG_WINDOW_ANIM_FRAME_START, 0);
        
        //Active
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_TYPE, 0);
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_LENGTH, 8);
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_ANIM_FRAMES, 4);
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_ANIM_FRAME_START, 3);
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_HAS_SFX, 1);
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_SFX, ability_proj_shoot);
        set_window_value(AT_EXTRA_3, 2, AG_WINDOW_SFX_FRAME, 0);
        
        //Endlag
        set_window_value(AT_EXTRA_3, 3, AG_WINDOW_TYPE, 0);
        set_window_value(AT_EXTRA_3, 3, AG_WINDOW_LENGTH, 2);
        set_window_value(AT_EXTRA_3, 3, AG_WINDOW_ANIM_FRAMES, 1);
        set_window_value(AT_EXTRA_3, 3, AG_WINDOW_ANIM_FRAME_START, 7);
        
        set_num_hitboxes(AT_EXTRA_3, 1);
        
        set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_TYPE, 2);
        set_hitbox_value(AT_EXTRA_3, 1, HG_WINDOW, 2);
        set_hitbox_value(AT_EXTRA_3, 1, HG_WINDOW_CREATION_FRAME, 3);
        set_hitbox_value(AT_EXTRA_3, 1, HG_LIFETIME, 600);
        set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_X, 24);
        set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_Y, -24);
        set_hitbox_value(AT_EXTRA_3, 1, HG_WIDTH, 64);
        set_hitbox_value(AT_EXTRA_3, 1, HG_HEIGHT, 64);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PRIORITY, 3);
        set_hitbox_value(AT_EXTRA_3, 1, HG_DAMAGE, 12);
        set_hitbox_value(AT_EXTRA_3, 1, HG_ANGLE, 45);
        set_hitbox_value(AT_EXTRA_3, 1, HG_BASE_KNOCKBACK, 4);
        set_hitbox_value(AT_EXTRA_3, 1, HG_KNOCKBACK_SCALING, 0.1);
        // set_hitbox_value(AT_EXTRA_3, 1, HG_HIT_LOCKOUT, 10);
        set_hitbox_value(AT_EXTRA_3, 1, HG_BASE_HITPAUSE, 18);
        set_hitbox_value(AT_EXTRA_3, 1, HG_HITPAUSE_SCALING, 0.8);
        set_hitbox_value(AT_EXTRA_3, 1, HG_VISUAL_EFFECT, 3);
        set_hitbox_value(AT_EXTRA_3, 1, HG_HIT_SFX, ability_proj_hit);
        
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_SPRITE, ability_proj);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_MASK, -1);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_COLLISION_SPRITE, ability_proj_col);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_HSPEED, 2);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_WALL_BEHAVIOR, 0);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_GROUND_BEHAVIOR, 0);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_IS_TRANSCENDENT, 1);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_DOES_NOT_REFLECT, 1);
        set_hitbox_value(AT_EXTRA_3, 1, HG_PROJECTILE_PARRY_STUN, 1);
        set_hitbox_value(AT_EXTRA_3, 1, HG_IGNORES_PROJECTILES, 1);
        
        
    newicon = ability_icon //Optional, replaces the kirby ability icon
    } //Kirby ability script ends here
}
if enemykirby != noone { //if kirby is in a match & has swallowed the character
    with oPlayer {
    	if (attack == AT_EXTRA_3 && window == 3) {
        	move_cooldown[AT_EXTRA_3] = 180;
    	}
    }
}


if has_rune("A") { //Photon platform for allies
// If teams is enabled
if (get_match_setting(SET_TEAMS) == 1) {
    //Scans all players
    with oPlayer {
        // If player is on team
        if (get_player_team(player) == get_player_team(other.player) && player != other.player) {
            
            //Ability becomes usable again
            if plat_timer <= 0 && plat_ == 0 {
                plat_ = 1;
                sound_play(asset_get("mfx_coin"));
                if !instance_exists(pb) && state != PS_DEAD {
                    pb = instance_create(x,y,"obj_article3");
                    pb.player_id = other.id;
                    pb.for_player = id;
                }
            }
            //Using the ability
            if (jump_down && plat_ == 1) {
                if (max_djumps == djumps && state == PS_DOUBLE_JUMP && state_timer >= 15 || state == PS_PRATFALL) {
                    plat_timer = plat_interval;
                    plat_ = 0;
                    sym_plat = instance_create(pb.x,pb.y,"obj_article_platform");
                    sym_plat.type = "other";
                    pb.state = -1;
                    sym_plat.for_player = id;
                    sound_play(asset_get("mfx_coin"));
                }
            }
            //Cooldown decay
            if plat_timer > 0 {
                plat_timer--;
            }
            // if (!instance_exists(self)) {
            //     // pb.state = -1;   state == PS_DEAD
            //     instance_destroy(pb);
            // }
        }
    }
}
}
if has_rune("C") {
    //Scans all players
    with oPlayer {
        // If player is on team
        if (get_player_team(player) == get_player_team(other.player) && player != other.player) {
            if state == PS_AIR_DODGE {
                // visible = false;
                air_dodge_speed = 16;
                outline_color = [other.sym_r2,other.sym_g2,other.sym_b2];
                init_shader();
            }
            else {
                // visible = true;
            }
        }
    }
}