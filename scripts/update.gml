//update.gml


// Long dodge
if has_rune_long_dodge && (state == PS_AIR_DODGE || state == PS_WAVELAND) {draw_indicator = false;}
//invisible = true; init_shader();
// else {  outline_color = [0,0,0];}outline_color = [sym_r0,sym_g0,sym_b0];


// Ultimate charge
if has_rune_shield_wall
|| has_rune_shield_gen
|| has_rune_spawn_point
{
	if state != PS_DEAD 
	&& state != PS_SPAWN
	&& state != PS_RESPAWN
	&& ult_charge < ult_cost
	&& !instance_exists(ult_instance)
	{
		ult_charge++;	//	Passively generate ultimate charge.
	}
}


// Cooldown Timers
if (barrier_timer > 0) {  barrier_timer--;  }
if (tp_timer > 0) {  tp_timer--;  }
if (turret_timer > 0) { turret_timer--; }


// Regenerate charges for turrets if max charges hasn't been reached
if (turret_charges < max_turrets) {
	var refresh_time = turret_rate * (max_turrets - turret_charges - 1);
if (turret_charges < turret_charges_max) {
	var refresh_time = turret_rate * (turret_charges_max - turret_charges - 1);
	if (turret_timer >= refresh_time){	// If the timer reaches 0
     	turret_charges++;				// Create a charge
 	}
 	else { // If the turret timer is less than required to meet max turrets, increase timer
 		turret_timer += turret_rate;
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


// Teleporter Movement
if attack == AT_USPECIAL {
	var tp_exit = teleporters[1];
	if instance_exists(tp_exit) && tp_exit.state == -1 {	// If teleporter exit hasn't deployed yet...
		
		
		var tp_height = 76;
		var current_position_x = tp_exit.x;
		var current_position_y = tp_exit.y;
		var next_position_x = current_position_x + tp_exit.x_velocity;
		var next_position_y = current_position_y + tp_exit.y_velocity;
		var is_colliding_solid = collision_line(current_position_x, current_position_y, next_position_x, next_position_y, asset_get("par_block"), false, true);	// If solid at projected location
		var is_colliding_plat = collision_line(current_position_x, current_position_y, next_position_x, next_position_y, asset_get("par_jumpthrough"), false, true);		// If solid at projected location
		
		// Horizontal movement
		var h_dir = right_down - left_down;
		if h_dir == 0 || is_colliding_solid || is_colliding_plat {
			tp_exit.x_velocity *= tp_exit.accel;	// Decellerate	
		}
		else {
			tp_exit.x_velocity += h_dir * tp_exit.accel;	// Accelerate
			tp_exit.x_velocity = clamp(tp_exit.x_velocity, -tp_exit.hsp_max, tp_exit.hsp_max);
		}
		
		// Vertical movement
		var v_dir = down_down - up_down;
		tp_exit.can_be_grounded = down_down;	// Pass through platforms if pressing down.
		if v_dir == 0 || is_colliding_solid || is_colliding_plat {
			tp_exit.y_velocity *= tp_exit.accel;	// Decellerate
			if !(right_down || left_down) { tp_exit.y_velocity = tp_exit.grav; }	// Gravity
		}
		else {	
			tp_exit.y_velocity += v_dir * tp_exit.accel;	// Accellerate
			tp_exit.y_velocity = clamp(tp_exit.y_velocity, -tp_exit.vsp_max, tp_exit.vsp_max);
		}
		
		spr_dir = sign(tp_exit.x - x);
		
		// Limit the range of exit teleporter.
		var tp_range_x = 256;
		tp_exit.x = clamp(tp_exit.x, x - tp_range_x, x + tp_range_x);
		var tp_range_y = 96;
		tp_exit.y = clamp(tp_exit.y, y - tp_range_y, y + tp_range_y);
		
		// Allow jumping.
		// if jump_pressed && !free {
		// 	clear_button_buffer(PC_JUMP_PRESSED);
		// 	vsp = -jump_speed;
		// 	sound_play(asset_get("sfx_jumpground"));
		// }
	}
}




// Teleporting
if instance_exists(teleporters[0]) && instance_exists(teleporters[1]) {
	with oPlayer {
		if "tp_tp_timer" in self {
			// The timer ticks down.
			if tp_tp_timer > 0 {	--tp_tp_timer;	}
			// The outline color resets after teleporting.
			else if tp_tp_timer == 0 {	outline_color = [0,0,0];	init_shader();	}
			
			if get_match_setting(SET_TEAMATTACK) == 1	// If team attack is enabled, enemies can teleport too.
			|| get_player_team(player) == get_player_team(other.player)		// If player is on the same team as Symmetra
			{
				if tp_tp_timer <= 0 && taunt_pressed {
					for (i = 0; i < 2; i++;) {
						var nearby_tp = other.teleporters[i];
						if instance_exists(nearby_tp)
						&& instance_place(x, y, nearby_tp)
						&& "state" in nearby_tp
						&& nearby_tp.state = 0 {
							var next_index = (i + 1) % 2;
							var far_tp = other.teleporters[next_index];
							tp_tp_timer = other.tp_interval;
							x = far_tp.x;
						    y = far_tp.y;
						    move_cooldown[AT_TAUNT] = other.tp_interval;
						    outline_color = [other.sym_r1, other.sym_g1, other.sym_b1];
						    init_shader();
						}
					}
				}
			}
		}
	}
}






// Cancel preview attacks
if (state == PS_HITSTUN || state == PS_HITSTUN_LAND || state == PS_TUMBLE || state == PS_PRATFALL || state == PS_PRATLAND || state == PS_FROZEN || state == PS_WRAPPED || state == PS_DEAD) {
    // if instance_exists(teleporter_entrance) && teleporter_entrance.state = -1 { instance_destroy(teleporter_entrance); }
    // if instance_exists(teleporter_exit) && teleporter_exit.state = -1 { instance_destroy(teleporter_exit); }

    sound_stop(sound_get("orb charging 1"));
}




// Spawn Point ultimate
if instance_exists(ult_instance) {
	
	// Find all dead teammates
	with oPlayer {
		if get_player_team(player) == get_player_team(other.player) && state == PS_DEAD {
			if array_find_index(other.dead_teammates, id) == -1 {array_push(other.dead_teammates, id)} // Add dead player to the array.
		}
	}
	
	var new_teammate_array = [];
	with dead_teammates {
		// Give dead players another stock.
        var current_stocks = get_player_stocks(id);
        if current_stocks <= 0 {set_player_stocks(id, 1);}
        
        // Respawn the dead players.
        set_state(PS_RESPAWN);
        x = other.ult_instance.x;
        y = other.ult_instance.y - 16 - char_height/2;
        
        // Apply teleport shader
        outline_color = [other.sym_r0, other.sym_g0, other.sym_b0];
        init_shader();
	}
    
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
