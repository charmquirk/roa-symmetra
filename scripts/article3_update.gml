//article3_update

if !("state" in self) { exit;}

// Manage shared behaviors between states.
switch state {
	case -1:
	case 2:
		break;
	case 0:
	case 1:
		// Death
		if health > health_max {	// If sentry takes too much damage...
			state = 2; // Deactivate.
			state_timer = 0;
			spawn_hit_fx(x, y - 16, 301);
		}
		
		// Invulnerability
		if damage_cd > 0 { // If turret took damage...
			damage_cd--; // Damage immunity timer ticks down.
			image_alpha = damage_alpha;
			// if state == 1 {	state = 0;	} // can't fire while hit
		}
		else { // If vulnerable...
			image_alpha = 1;
		}
		break;
}


// Target selection
if target == noone && state == 0 && array_length(targets) > 0 {
    // Calculate the distance from each target
    with targets {
		var new_index = array_find_index(other.targets, id)
		if new_index != -1 {
			other.distances[new_index] = point_distance(other.x, other.y, x, y - char_height/2);
		}
    }
    
    if array_length(distances) > 0 {
    	// Compare the distances.
	    var shortest_distance_index = 0;
		for (var i = 1; i < array_length(distances); i++) {
			if (distances[i] < targets[shortest_distance_index]) {
				shortest_distance_index = i;
			}
		}
		
		if distances[shortest_distance_index] < aim_range {
			target = targets[shortest_distance_index]
			// if is_healing {
			// 	target.toggle_healing_target(id, true);
			// }
			// else{
			// 	target.toggle_damage_target(id, true);
			// }
			state = 1;
			state_timer = 0;
			target.is_healing_target = true;
			print_debug("Turret selected player!")
		}
    }
}


if instance_exists(target) {
	with oPlayer {
    	if id == other.target.id {
    		other.target_distance = point_distance(other.x, other.y, x, y - char_height/2);
    		other.target_angle = point_direction(other.x, other.y, x, y - char_height/2);
    	}
    }
	
	if target_distance > aim_range {	// If target is out of range...
		deselect_target(target);	// Break connection.
	}
}


if instance_exists(target) {
	// If the target is invulnerable...
	if (target.state == PS_DEAD
	|| target.state == PS_AIR_DODGE
	|| target.state == PS_ROLL_BACKWARD
	|| target.state == PS_ROLL_FORWARD
	|| target.state == PS_RESPAWN
	|| target.state == PS_SPAWN
	|| target.state == PS_PARRY
	|| target.state == PS_PARRY_START)
	{	// Break connection.
		deselect_target(target);
	}
}

// Apply damage and effects to target.
if instance_exists(target) {
	chip_increment++;
	if chip_increment == chip_threshold {
        take_damage(target.player, player_id.player, chip_damage);
        // spawn_hit_fx(sentry_target.x, sentry_target.y - sentry_target.char_height/2, cfx_heal);
        chip_increment = 0;
        if !is_healing {
            if target.vsp < 0 {					// If jumping...
            	target.vsp *= slow_vsp;	// Slow down jump.
            }
            target.hsp *= slow_hsp;		// Slow down walk, dash, etc.
            if target.state_cat != SC_HITSTUN {		// If in hitstun...
                target.hsp = clamp(target.hsp, -3, 3);		// Reduce movement for better combos.
                // hsp = clamp(hsp, -walk_speed, walk_speed);
            }
        }
    }
}


// Turret takes damage.
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


// Alpha Animation & Sprite
mask_index = free ? sprite_get("sentry_aerial_mask") : sprite_get("sentry_grounded_mask");
var new_sprite = "";
switch (state) {
	case -1:
		new_sprite = free ? "sentry_aerial_deactivated" : "sentry_grounded_deactivated";
		if image_alpha <= 1 {
			image_alpha = state_timer * deploy_speed;
		}
		
		if state_timer >= 2/deploy_speed { // If the state time is double what is needed to fade in.
			state = 0;	// Activate
	 		state_timer = 0;
	 		sprite_index = free ? sprite_get("sentry_aerial"): sprite_get("sentry_grounded");
		}
		break;
	case 0:
    case 1:
    	image_alpha = damage_cd > 0 ? damage_alpha : 1;		// Translucent when invlunerable.
        new_sprite = free ? "sentry_aerial" : "sentry_grounded";
        break;
	case 2:
		new_sprite = free ? "sentry_aerial_deactivated" : "sentry_grounded_deactivated";
		if image_alpha > 0 {
			image_alpha -= deploy_speed;
		}
		
		if state_timer >= 2/deploy_speed { // If the state time is double what is needed to fade out.
			instance_destroy();
            exit;
		}
		break;
}
if new_sprite != "" {	sprite_index = sprite_get(new_sprite);	}


// switch (state) {
//     case -1:       //placement
//     	if has_rune("F") && has_rune("I"){ // hold an release placemnt
//     		if player_id.turret_placing == false {
//     			if image_alpha < 1 {	image_alpha += deploy_speed;} //not oubling deploy speed since it goes from 0.5 to 1
// 			}
// 			else { image_alpha = placement_alpha; }
// 			if state_timer >= (1-placement_alpha)/deploy_speed {
//     			state = 0;
//     	 		state_timer = 0;
//     	 		damage_cd = 0; //turrets become vulnerable
//     	 		// Frame perfect sprite change
//     	 		if free { sprite_index = sprite_get("sentry_aerial"); mask_index = sprite_get("sentry_aerial_mask");}
// 				else { sprite_index = sprite_get("sentry_grounded"); mask_index = sprite_get("sentry_grounded_mask");}
//     		}
//     	}
//     	else { //instant placement
//     		if image_alpha < 1 {	image_alpha += deploy_speed*2;} //doubling deploy speed since it goes from 0 to 1
//     		if state_timer >= 1/deploy_speed { //if completed both animations
//     			state = 0;
//     	 		state_timer = 0;
//     	 		damage_cd = 0; //turrets become vulnerable
//     	 		// Frame perfect sprite change
//     	 		if free { sprite_index = sprite_get("sentry_aerial"); mask_index = sprite_get("sentry_aerial_mask");}
// 				else { sprite_index = sprite_get("sentry_grounded"); mask_index = sprite_get("sentry_grounded_mask");}
//     		}
//     	}
//         break;
//     case 0:         //inactive
//         sentry_target = noone;
//         if has_rune("I") && !has_rune("F") {	hsp = max_flying_speed*flying_dir; } //searching speed
//         break;
//     case 1:         //active
//     	if sentry_target == noone && sentry_health < sentry_max_health { state = 0; }
//         if has_rune("I") && !has_rune("F") {	hsp = flying_speed*flying_dir; } //targetting speed
//         break;
//     case 2:         //destroyed
//     	if free { sprite_index = sprite_get("sentry_aerial_deactivated"); }
//     	else { sprite_index = sprite_get("sentry_grounded_deactivated"); }
    	
//         if array_find_index(player_id.turrets, id) != -1 {  // If in array
//             if array_length(player_id.turrets) == 1 { // If alone in array
//                 player_id.turrets[0] = noone;
//             }
//             else {
//                 var pos_array = array_find_index(player_id.turrets, id);
//                 player_id.turrets[pos_array] = noone;       //Erase from array
//             }
//         }
//         image_alpha -= deploy_speed;
//         if image_alpha <= 0 {
//             instance_destroy();
//             exit;
//         }
//         break;
// }

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
   
#define deselect_target(old_target)
if old_target == target && old_target != noone {
	// if is_healing {
	// 	target.toggle_healing_target(self, false);
	// }
	// else{
	// 	target.toggle_damage_target(self, false);
	// }
	target = noone;
	state = 0;
	target_angle = 0;
}

// #define toggle_damage_target(turret, toggle)
// if toggle {
//     turrets_damaging = add_turret(turrets_damaging, turret);
// }
// else {
//     turrets_damaging = remove_turret(turrets_damaging, turret);
// }

// if is_damage_target != toggle {
//     dash_speed = toggle ? 3 : original_dash_speed;
//     is_damage_target = toggle;
// }

// #define toggle_healing_target(turret, toggle)
// if toggle {
//     turrets_healing = add_turret(turrets_healing, turret);
// }
// else {
//     turrets_healing = remove_turret(turrets_healing, turret);
// }
// if is_healing_target != toggle {
//     is_healing_target = toggle;
// }

// #define add_turret(turret_array, turret)
// var index = array_find_index(turret_array, turret);
// if index == -1 {
//     array_push(turret_array, turret);
// }

// #define remove_turret(turret_array, turret)
// var index = 0;
// index = array_find_index(turret_array, turret);
// if index != -1 {
//     turret_array[index] = noone;    // Clear the turret.
// }

// var new_array = [];
// for (i=0; i < array_length(turret_array); i++)
// {
//     if turret_array[i] != noone {
//         array_push(new_array, turret_array[i]);     // Rebuild array with only turrets that exist.
//     }
// }
// turret_array = array_clone(new_array);
// return turret_array;
