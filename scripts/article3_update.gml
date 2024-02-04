//article3_update

if state == 0 || state == 1 {
	if free {
    	sprite_index = sprite_get("sentry_aerial");           
    	mask_index = sprite_get("sentry_aerial_mask");
	}
	else {
    	sprite_index = sprite_get("sentry_grounded");
    	mask_index = sprite_get("sentry_grounded_mask");
	}
	if damage_cd > 0 { // turret immunity window
		damage_cd--; // Damage immunity timer ticks down.
		image_alpha = damage_alpha; //change opacity if took damage
		// if state == 1 {	state = 0;	} // can't fire while hit
	}
	else { //If damage is on cooldown
		image_alpha = 1;
	}
	if sentry_health >= sentry_max_health { state = 2; spawn_hit_fx(x, y - 16, 301); }
	if has_rune("I") && !has_rune("F") { if state_timer >= lifetime {	state = 2;}   }// If it can fly but it cant be placed and its lifetime expired
}
else {
	if free {
    	sprite_index = sprite_get("sentry_aerial_deactivated");           
    	mask_index = sprite_get("sentry_aerial_mask");
	}
	else {
    	sprite_index = sprite_get("sentry_grounded_deactivated");
    	mask_index = sprite_get("sentry_grounded_mask");
	}
}




if sentry_target == noone && state == 0 {
    sentry_chip = 0;
    
    if has_rune("H") {
        with player_id {        // Target yourself
            other.t_dist = point_distance(x, y-char_height/2, other.x, other.y);		// Distance between target and player       
            if other.t_dist <= other.sentry_range {
                other.state = 1;
                other.sentry_target = id;
            }
        }
    }
    
    if sentry_target == noone {
        if has_rune("H") {
            with oPlayer {          // Target teammates
                if (id != other.player_id && get_player_team(player) == get_player_team(other.player_id.player)) {
                    other.t_dist = point_distance(x, y-char_height/2, other.x, other.y);		// Distance between target and player 
                    if other.t_dist <= other.sentry_range {
                        other.state = 1;
                        other.sentry_target = id;
                    }
                }
            }
        }
        else {
            with oPlayer {          // Target others
                if (get_match_setting(SET_TEAMATTACK) == true || (id != other.player_id && get_player_team(player) != get_player_team(other.player_id.player))) {
                    other.t_dist = point_distance(x, y-char_height/2, other.x, other.y);		// Distance between target and player 
                    if other.t_dist <= other.sentry_range {
                        other.state = 1;
                        other.sentry_target = id;
                    }
                }
            }
        }
    }
}
if sentry_target != noone {
	if !instance_exists(sentry_target) || (sentry_target.state == PS_DEAD || sentry_target.state == PS_AIR_DODGE || sentry_target.state == PS_ROLL_BACKWARD || sentry_target.state == PS_ROLL_FORWARD || sentry_target.state == PS_RESPAWN || sentry_target.state == PS_SPAWN || sentry_target.state == PS_PARRY || sentry_target.state == PS_PARRY_START){
		sentry_target = noone;
		sentry_target.dash_speed = sentry_target.orig_dash_speed;
		state = 0;
	}
	else {
    if has_rune("H") { //healing turret
        with sentry_target {
            other.t_dist = point_distance(x, y-char_height/2, other.x, other.y);		// Distance between target and player
            other.t_ang = point_direction(other.x, other.y, x, y-char_height/2);

            if other.t_dist <= other.sentry_range {
                other.sentry_target = id;
            }
            else {
                other.t_ang = 0;
                other.state = 0;
                other.sentry_target = noone;
                dash_speed = orig_dash_speed;
                if other.sentry_target != noone {	other.hsp = other.max_flying_speed*other.flying_dir; } //searching speed
            }
        }
        sentry_chip++;
        if sentry_chip == sentry_chip_threshold && sentry_target != noone {
            take_damage(sentry_target.player, player_id.player, -sentry_damage);
            // spawn_hit_fx(sentry_target.x, sentry_target.y - sentry_target.char_height/2, cfx_heal);
            sentry_chip = 0;
        }
    }
    else { //damage turret
        with sentry_target {
            other.t_dist = point_distance(x, y-char_height/2, other.x, other.y);		// Distance between target and player
            other.t_ang = point_direction(other.x, other.y, x, y-char_height/2);
            if other.t_dist <= other.sentry_range {
                other.sentry_target = id;
                
                if free {
                    if vsp < 0 {vsp = vsp*other.sentry_slow_v;}
                    hsp = hsp*other.sentry_slow_h;
                    if state_cat != SC_HITSTUN {
                        hsp = clamp(hsp, -3, 3);
                        // hsp = clamp(hsp, -walk_speed, walk_speed);
                    }   
                }
                else {
                    if vsp < 0 {vsp = vsp*other.sentry_slow_v;}
                    hsp = hsp*other.sentry_slow_h;
                    if state_cat != SC_HITSTUN {
                        hsp = clamp(hsp, -3, 3);
                        // hsp = clamp(hsp, -air_max_speed, air_max_speed);
                        dash_speed = 3;
                    }
                }
            }    
            else {
                other.t_ang = 0;
                other.state = 0;
                other.sentry_target = noone;
                dash_speed = orig_dash_speed;
            }
        }
        sentry_chip++;
        if sentry_chip == sentry_chip_threshold && sentry_target != noone {
            take_damage(sentry_target.player, player_id.player, sentry_damage);
            sentry_chip = 0;
            // with sentry_target {
            // 	if other.has_rune("H") { spawn_hit_fx(x, y - char_height/2, other.cfx_heal); }
            // 	else { spawn_hit_fx(x, y - char_height/2, other.cfx_sentry_hit); }
            // }
			// spawn_hit_fx(sentry_target.x, sentry_target.y - sentry_target.char_height/2, cfx_sentry_fire); 
        }
    }
	}
}


// Damage Function
if state != 2 && state != -1 {
	if instance_place(x, y, pHitBox) && damage_cd <= 0 {	
		with pHitBox {
			if get_player_team(player_id.player) != get_player_team(other.player_id.player) || get_match_setting(SET_TEAMATTACK) {
				if instance_place(x, y, other.id) {
					if damage > 0 && other.damage_cd <= 0 {
						other.sentry_health += damage;
						other.damage_cd = other.damage_base_cd + hitpause;
						// print_debug("other = " + string(other.id));
						// print_debug("hbox_damage = " + string(damage));
					}
				}
			}
		}
	}
}

switch (state) {
    case -1:       //placement
    	if has_rune("F") && has_rune("I"){ // hold an release placemnt
    		if player_id.turret_placing == false {
    			if image_alpha < 1 {	image_alpha += deploy_speed;} //not oubling deploy speed since it goes from 0.5 to 1
			}
			else { image_alpha = placement_alpha; }
			if state_timer >= (1-placement_alpha)/deploy_speed {
    			state = 0;
    	 		state_timer = 0;
    	 		damage_cd = 0; //turrets become vulnerable
    	 		// Frame perfect sprite change
    	 		if free { sprite_index = sprite_get("sentry_aerial"); mask_index = sprite_get("sentry_aerial_mask");}
				else { sprite_index = sprite_get("sentry_grounded"); mask_index = sprite_get("sentry_grounded_mask");}
    		}
    	}
    	else { //instant placement
    		if image_alpha < 1 {	image_alpha += deploy_speed*2;} //doubling deploy speed since it goes from 0 to 1
    		if state_timer >= 1/deploy_speed { //if completed both animations
    			state = 0;
    	 		state_timer = 0;
    	 		damage_cd = 0; //turrets become vulnerable
    	 		// Frame perfect sprite change
    	 		if free { sprite_index = sprite_get("sentry_aerial"); mask_index = sprite_get("sentry_aerial_mask");}
				else { sprite_index = sprite_get("sentry_grounded"); mask_index = sprite_get("sentry_grounded_mask");}
    		}
    	}
        break;
    case 0:         //inactive
        sentry_target = noone;
        if has_rune("I") && !has_rune("F") {	hsp = max_flying_speed*flying_dir; } //searching speed
        break;
    case 1:         //active
    	if sentry_target == noone && sentry_health < sentry_max_health { state = 0; }
        if has_rune("I") && !has_rune("F") {	hsp = flying_speed*flying_dir; } //targetting speed
        break;
    case 2:         //destroyed
    	if free { sprite_index = sprite_get("sentry_aerial_deactivated"); }
    	else { sprite_index = sprite_get("sentry_grounded_deactivated"); }
    	
        if array_find_index(player_id.turrets, id) != -1 {  // If in array
            if array_length(player_id.turrets) == 1 { // If alone in array
                player_id.turrets[0] = noone;
            }
            else {
                var pos_array = array_find_index(player_id.turrets, id);
                player_id.turrets[pos_array] = noone;       //Erase from array
            }
        }
        image_alpha -= deploy_speed;
        if image_alpha <= 0 {
            instance_destroy();
            exit;
        }
        break;
}

if state == -1 && player_id.turret_placing == true { state_timer = 0; } //if placing turret, don't limit lifetime
else {state_timer++;}
 //state timers for state 0 and state 1 are the same since they dont reset when switching modes.

#define make_hitbox 
    // make_hitbox(_attack_name, _index, (value_name, value)... )
    // Sets hitbox values for the given hitbox.
    // e.g. make_hitbox(AT_BAIR, 1,
    //         HG_PARENT_HITBOX, 1,
    //         HG_HITBOX_TYPE, 1
    //     );
    var _attack_name = argument[0];
    var _index = argument[1];
    for(var i=2; i<=argument_count-1; i+=2) {
        set_hitbox_value(_attack_name, _index, argument[i], argument[i+1]);
    }
