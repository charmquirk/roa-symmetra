//article2_update

//
// Teleporters
//



//Damage function
if state == 0 { //if not deploying or destroyed
	if instance_place(x, y, pHitBox) && damage_cd <= 0 {	
		with pHitBox {
			if get_player_team(player_id.player) != get_player_team(other.player_id.player) || get_match_setting(SET_TEAMATTACK) {
				if instance_place(x, y, other.id) {
					if ("damage_cd" in other) && damage > 0 && other.damage_cd <= 0 {
						other.tp_health += damage;
						other.damage_cd = other.damage_base_cd + hitpause;
					}
				}
			}
		}
	}
}

if ("tp_health" in self) && tp_health >= tp_max_health {
    state = 1;
    state_timer = 0;
    damage_cd = 0; //reset damage cooldown
    player_id.tp_timer = player_id.tp_rate;
    // spawn_hit_fx(x, y - 16, 301);
    sound_play(sound_get("teleporter destroyed"))
}

// Re-initiates based on type, constantly checks.
if state != 1 {
    switch(type) {
        case "entrance" :
            if ((instance_place(x,y,player_id.teleporter_exit) && state == 0) || !instance_exists(player_id.teleporter_exit) )  {       // Destroy teleporters if they collide or if the other gets destroyed
                state = 1;
                state_timer = 0;
                // spawn_hit_fx(x, y - 16, 301);
                // sound_play(sound_get("teleporter destroyed"))
            }
            break;
        case "exit" :
            if ((instance_place(x,y,player_id.teleporter_entrance) && state == 0) || !instance_exists(player_id.teleporter_entrance) ) {        // Destroy teleporters if they collide or if the other gets destroyed 
                state = 1;
                state_timer = 0;
                // spawn_hit_fx(x, y - 16, 301);
                // sound_play(sound_get("teleporter destroyed"))
            }
            break;
        case "ultimate" :
        	tp_max_health = 120;
        	vsp = grav;
        	mask_index = sprite_get("teleporter_pad_minimask");
        	break;
    }
}

if ("damage_cd" in self) && damage_cd > 0 && state = 0 { // turret immunity window
		damage_cd--; // Damage immunity timer ticks down.
		image_alpha = damage_alpha; //change opacity if took damage
		// if state == 1 {	state = 0;	} // can't fire while hit
	}
	else { //If damage is on cooldown
		image_alpha = 1;
}


switch(state) {
    case -1 :
        if type == "entrance" || type == "ultimate" {
            x = player_id.x;
            if !player_id.free { y = player_id.y; }
        }
        break;
    case 0 :    //Default 
        if free { vsp = 8;}
        // if type == "entrance" || type == "exit" {sprite_index = sprite_get("teleporter_pad");}
        sprite_index = sprite_get("teleporter_pad");
        
        // if state_timer >= lifetime { //TP expires
        //     state = 1;
        //     state_timer = 0;
        // }
        break;
    case 1 :    //Destruction
        spawn_hit_fx(x,y-32,HFX_GEN_OMNI);
        if type == "ultimate" {sound_play(sound_get("teleporter destroyed"));}
        
        switch(type) {
            case "entrance" :
                player_id.teleporters[0] = noone;
                player_id.teleporter_entrance = noone;
                break;
            case "exit" :
                player_id.teleporters[1] = noone;
                player_id.teleporter_exit = noone;
                break;
        }
        instance_destroy();
        exit;
        break;
}



state_timer++;