//article3_post_draw        in front of sprite

if !("state" in self) { exit;   }
var new_sprite = "";
var new_alpha = image_alpha;
switch state {
    case -1:
        new_sprite = free ? "sentry_aerial_inactive" : "sentry_grounded_inactive";
        var blue_time = placement_alpha/deploy_speed*2;
        var new_state_time = state_timer - blue_time;
        new_alpha = state_timer > blue_time ? new_state_time * deploy_speed * 2 : 0;
        break;
    case 0:
        new_sprite = "sentry_inactive"
        break;
    case 1:
        draw_sprite_ext(sprite_get("beam_w1"), -1, x, y, target_distance/2, 1, target_angle, c_white, image_alpha); // Draw turret beam
        new_sprite = "sentry_active"
        break;
}

if new_sprite != "" {    draw_sprite_ext(sprite_get(new_sprite), -1, x, y, 1, 1, target_angle, c_white, new_alpha);  }   // Draw turret head

// draw_debug_text(x, y, "State: " + string(state));
// draw_debug_text(x-15, y-32, "Timer: " + string(state_timer));
// draw_debug_text(x+15, y+32, string(chip_increment));
