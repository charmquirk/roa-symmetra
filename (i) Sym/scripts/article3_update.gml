//article3_update
if for_player != noone {
    if !instance_exists(for_player) {
        instance_destroy(self);
        exit;
    }
}


x = for_player.x;
y = for_player.y +24;
with oPlayer {
    if other.for_player == id {
        // if state_cat == SC_AIR_NEUTRAL || state_cat == SC_GROUND_NEUTRAL {
        // other.state = state_lib.idle;
        if plat_ == 1 {
            other.state = 0;
            if (state == PS_DOUBLE_JUMP || state == PS_FIRST_JUMP || state == PS_PRATFALL) {
                
                if (state == PS_DOUBLE_JUMP || state == PS_PRATFALL) {
                    other.state = 2;
                }
                if (state == PS_FIRST_JUMP) {
                    other.state = 1;
                }
            }
            else {
                other.state = 0;
            }
            
            // else {
                // other.state = 0;
                // if state_cat == SC_GROUND_NEUTRAL || state_cat == SC_GROUND_COMMITTED {
                //     other.visible = false;
                // }
                // else {
                //     other.visible = true;
                // }
            // }
        }
        else {
            other.state = -1;
            // if state_cat == SC_GROUND_NEUTRAL || state_cat == SC_GROUND_COMMITTED {
            //     other.visible = false;
            // }
            // else {
            //     other.visible = true;
            // }
        }
        // if state == PS_DEAD {
        //     pb.instance_destroy();
        // }
    }
}

switch (state) {
     case -1:
        sprite_index = sprite_get("pb_cooldown");
        
        image_index = image_number*((for_player.plat_interval-for_player.plat_timer)/for_player.plat_interval);
        break;
    case 0:
        sprite_index = sprite_get("pb_inactive");
        break;
    case 1:
        sprite_index = sprite_get("pb_ready");
        break;
    case 2:
        sprite_index = sprite_get("pb_active");
        break;
        
}

// if (for_player.state == PS_DEAD) {
//     state = -1;
//     // !instance_exists(for_player)
// }
// if instance_find(for_player, 1) == noone {
//     instance_destroy(self);
// }




state_timer++;