//update.gml


// Long dodge
if has_rune_long_dodge && (state == PS_AIR_DODGE || state == PS_WAVELAND) {draw_indicator = false;}
//invisible = true; init_shader();
// else {  outline_color = [0,0,0];}outline_color = [sym_r0,sym_g0,sym_b0];


//Ultimate charge
if has_rune("L") && is_fighting && ult_charge < ult_cost && !instance_exists(teleporter_ultimate) { //if not dead or spawning //
	ult_charge++;//passively generate ultimate charge
}


// Cooldown Timers
if (barrier_timer > 0) {  barrier_timer--;  }
if (tp_timer > 0) {  tp_timer--;  }
if (turret_timer > 0) { turret_timer--; }


// Regenerate charges for turrets if max charges hasn't been reached
if (turret_charges < max_turrets) {
	var refresh_time = turret_rate * (max_turrets - turret_charges - 1);
	if (turret_timer >= refresh_time){	// If the timer reaches 0
     	turret_charges++;				// Create a charge
 	}
 	else { // If the turret timer is less than required to meet max turrets, increase timer
 		turret_timer += turret_rate;
 	}
}


// Shrink array to remove gaps.
if array_length(turrets) > 0 {
	var new_turret_array = [];
    for (i = 0; i < array_length(turrets); i++;) {  //Start at first index and oldest turret
    	if turrets[i] != noone {
    		array_push(new_turret_array,turrets[i]);
    	}
    }
    if !array_equals(turrets, new_turret_array) {
	    turrets = [];
	    turrets = array_clone(new_turret_array);
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
		if teleporter_exit.tp_yv != 0 {teleporter_exit.vsp = clamp(teleporter_exit.vsp, -teleporter_exit.vsp_max, teleporter_exit.vsp_max);}
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




// Spawn Point ultimate
if instance_exists(teleporter_ultimate) {
	
	// Find all dead teammates
	with oPlayer {
		if get_player_team(player) == get_player_team(other.player) && state == PS_DEAD {
			if array_find_index(other.dead_teammates, id) == -1 {array_push(other.dead_teammates, id)} // Add dead player to the array.
		}
	}
	
	var new_teammate_array = [];
	with dead_teammates {
		// Give dead players another stock
        var current_stocks = get_player_stocks(id);
        if current_stocks <= 0 {set_player_stocks(id, 1);}
        
        // Respawn the dead players
        set_state(PS_RESPAWN);
        x = other.teleporter_ultimate.x;
        y = other.teleporter_ultimate.y - 16 - char_height/2;
        
        // Apply teleport shader
        outline_color = [other.sym_r0, other.sym_g0, other.sym_b0];
        init_shader();
	}
	// for (m = 0; m < array_length(dead_teammates); m++;) {
		
	// 	// Give dead players another stock
 //       var current_stocks = get_player_stocks(m);
 //       if current_stocks <= 0 {set_player_stocks(m, 1);}
        
 //       // Respawn the dead players
 //       m.set_state(PS_RESPAWN);
 //       m.x = teleporter_ultimate.x;
 //       m.y = teleporter_ultimate.y - 16 - m.char_height/2;
        
 //       // Apply teleport shader
 //       m.outline_color = [sym_r0, sym_g0, sym_b0];
 //       m.init_shader();
 //   }
    
    // Clear the array
    dead_teammates = [];
}
// Clear empty spaces and reoganize array
if array_length(dead_teammates) > 0 {
	var new_teammate_array = [];
    for (m = 0; m < array_length(tp_team); m++;) {
        if dead_teammates[m] != noone {
        	array_push(new_teammate_array, dead_teammates[m]);
        }
    }
    if !array_equals(dead_teammates, new_teammate_array){
    	dead_teammates = [];
    	dead_teammates = array_clone(new_teammate_array);
    }    
}


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
