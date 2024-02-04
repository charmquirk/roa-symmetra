// Platform update
// image_index = min(image_index+.1, 0);

switch (type) {
    case "self" :
        sprite_index = sprite_get("platform");
        mask_index = -1;
        if construct_direction == 0 || construct_direction == 2{
            lifetime = player_id.construct_rate/2;
        }
        else {
            lifetime = player_id.construct_rate;
        }
        break;
    case "other" :
        sprite_index = sprite_get("pb_plat");
        mask_index = -1;
        lifetime = 40;
        break;
}

if state_timer > lifetime {
    state = 1;
}
switch(state) {
    case 0:
        if type == "self" {
            if construct_direction == -1 { hsp = -player_id.construct_speed; }
            if construct_direction == 1 { hsp = player_id.construct_speed; }
            if construct_direction == 2 { x = player_id.x; y = player_id.y; }
        }
        break;
    case 1:
        if type == "self" {
            if array_find_index(player_id.constructs, id) != -1 {  // If in array
                var pos_array = array_find_index(player_id.constructs, id);
                if array_length(player_id.constructs) == 1 { // If alone in array
                    player_id.constructs[0] = noone;
                }
                else {
                    player_id.constructs[pos_array] = noone;       //Erase from array
                }
            }
        }
        image_index = 1;
        image_alpha -= anim_speed;
        if image_alpha <= 0 {
            instance_destroy();
            exit;
        }
        // image_index += anim_speed;
        // if state_timer >= image_number/anim_speed - 1 {
        //     image_index = image_number;
        //     instance_destroy();
        //     exit;
        // }
        // break;
}
state_timer++;