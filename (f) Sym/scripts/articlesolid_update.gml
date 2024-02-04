//articlesolid_update



// switch(type) {
    
// }




switch(type) {
    case "horizontal":
        sprite_index = sprite_get("solid_horizontal");
        mask_index = sprite_get("solid_horizontal");
        if (state_timer > lifetime_h) {
            with player_id {
                if array_length(solids) > 0 {
                    solids[array_length(solids)-1].state = 1;
                    solids[array_length(solids)-1].state_timer = 0;
                    solids = array_slice(solids, 0, array_length(solids)-1);
                }
            }
            
        }
        break;
    case "vertical":
        sprite_index = sprite_get("solid_vertical");
        mask_index = sprite_get("solid_vertical");
        if (state_timer > lifetime_v) {
            state = 1;
            state_timer = 0;
        }
        break;
}

switch(state) {
    case 0:
        break;
    case 1:
        image_index = 1;
        image_alpha -= 0.02;
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