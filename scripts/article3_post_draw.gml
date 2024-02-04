//article3_post_draw        in front of sprite

if state == 0 {  draw_sprite_ext(sprite_get("sentry_inactive"), -1, x, y, 1, 1, 0, c_white, (damage_cd > 0) ? damage_alpha : 1); } //draw turret head

if sentry_target != noone {
    if t_dist <= sentry_range && state == 1 {
        draw_sprite_ext(sprite_get("beam_w1"), -1, x, y, t_dist/2, 1, t_ang, c_white, (damage_cd > 0) ? damage_alpha : 1);         //draw turret beam
        // if damage_cd > 0 {
        draw_sprite_ext(sprite_get("sentry_active"), -1, x, y, 1, 1, t_ang, c_white, (damage_cd > 0) ? damage_alpha : 1); //draw duplicate turret to cover beam
    }
}
// else {
    
// }

// if state == -1 {
//     if image_alpha >= 1 { draw_sprite_ext(sprite_get("sentry_inactive"), -1, x, y, 1, 1, 0, c_white, 1); }
//     if free {
//         if image_alpha < 1 { draw_sprite_ext(sprite_get("sentry_aerial_deactivated"), -1, x, y, 1, 1, 0, c_white, 2*state_timer*deploy_speed); }
//         else { draw_sprite_ext(sprite_get("sentry_aerial_deactivated"), -1, x, y, 1, 1, 0, c_white, 1-(2*state_timer*deploy_speed)); }
//     }
//     else {
//         if image_alpha < 1 { draw_sprite_ext(sprite_get("sentry_grounded_deactivated"), -1, x, y, 1, 1, 0, c_white, 2*state_timer*deploy_speed); }
//         else { draw_sprite_ext(sprite_get("sentry_grounded_deactivated"), -1, x, y, 1, 1, 0, c_white, 1-(2*state_timer*deploy_speed)); }
//     }
// }
if state == -1 && image_alpha >= 1 { //if deploying and blue phase completed
// Transition from blue to real
    if free {
        draw_sprite_ext(sprite_get("sentry_aerial_inactive"), -1, x, y, 1, 1, 0, c_white, (state_timer-(0.5/deploy_speed))*(deploy_speed*2));
    }
    else {
        draw_sprite_ext(sprite_get("sentry_grounded_inactive"), -1, x, y, 1, 1, 0, c_white, (state_timer-(0.5/deploy_speed))*(deploy_speed*2)); //state timer it took to finish first animation * deploy_speed
    }
}

// draw_debug_text(x,y,"State: " + string(state));
// draw_debug_text(x-15,y-32,"Timer: " + string(state_timer));
// draw_debug_text(x-15,y-32,string(sentry_chip));