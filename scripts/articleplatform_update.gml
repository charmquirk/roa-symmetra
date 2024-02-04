// Platform update
// image_index = min(image_index+.1, 0);


if state_timer > 40 {
    state = 1;
}
switch(state) {
    case 0:
        break;
    case 1:
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