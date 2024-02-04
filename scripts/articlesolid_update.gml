// //articlesolid_update


switch(state) {
    case -1:

        image_xscale += growth_speed;
        image_yscale = image_xscale;
        
        if image_xscale >= 1 {
            state = 0;
            state_timer = 0;
        }
        break;
    case 0:
        image_index = 0;
        mask_index = -1;
        image_alpha = 1;
        var room_edge = 96;
        
        if (x < 0 || x > room_width || y < 0 || y > room_height + room_edge ) { //If outside room
            state = 1;  //set to destroyed
            state_timer = 0;
        }
        if construct_direction == -1 { hsp = -player_id.construct_speed; }
        if construct_direction == 1 { hsp = player_id.construct_speed; }
        if construct_direction == 2 {
            lifetime = follow_time;
            x = player_id.x;
            y = player_id.y + 48;
            if state_timer >= lifetime {
                state = 1;  //set to destroyed
                state_timer = 0;
            }
        }
        break;
    case 1:
        if array_find_index(player_id.constructs, id) != -1 {  // If in array
            var pos_array = array_find_index(player_id.constructs, id);
            if array_length(player_id.constructs) == 1 { // If alone in array
                player_id.constructs[0] = noone;
            }
            else {
                player_id.constructs[pos_array] = noone;       //Erase from array
            }
        }
        mask_index = asset_get("empty_sprite"); //destroy mask
        image_index = 1;
        image_alpha -= 0.05;
        
        if image_alpha <= 0 {
            instance_destroy();
            exit;
        }
        // image_index += anim_speed;
        // if state_timer == image_number/anim_speed - 1{
        //     image_index = image_number;
        //     instance_destroy();
        //     exit;
        //     break;
        // }
        
        
}
state_timer++;