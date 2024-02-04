//article2_update

//
// Teleporters
//

// Re-initiates based on type
if state == 0 {
    switch(type) {
        case "entrance" :
            if ((instance_place(x,y,player_id.teleporter_exit) && state == 0) || !instance_exists(player_id.teleporter_exit) )  {       // Destroy teleporters if they collide or if the other gets destroyed
                state = 1;
                state_timer = 0;
            }
            break;
        case "exit" :
            if ((instance_place(x,y,player_id.teleporter_entrance) && state == 0) || !instance_exists(player_id.teleporter_entrance) ) {        // Destroy teleporters if they collide or if the other gets destroyed 
                state = 1;
                state_timer = 0;
            }
            break;
    }
}

if state != 1 { //If not destroyed
var tp_margin = 128;
    if (x < 0 - tp_margin || x > room_width + tp_margin || y < 0 - tp_margin || y > room_height + tp_margin ) { //If outside room
        state = 1;  //set to destroyed
        state_timer = 0;
    }
}

if destroyed == true { state = 1; }

switch(state) {
    case -1 :
        sprite_index = sprite_get("teleportal_preview");
        if type == "entrance" {
            x = player_id.x;
            y = player_id.y - 32;
        }
        break;
    case 0 :    //Default 
        sprite_index = sprite_get("teleportal");
        if state_timer > lifetime - anim_close {
             
            image_alpha -= 1/anim_close;
            if image_alpha <= min_alpha {
                state = 1;
                state_timer = 0;
            }
        }
        else {
            image_alpha = 1 + min_alpha // offsets aplha before animation
        }
        break;
    case 1 :    //Destruction
        spawn_hit_fx(x,y,HFX_GEN_OMNI);
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