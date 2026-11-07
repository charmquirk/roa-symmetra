//article2_post_draw        in front of sprite

if !("state" in self) { exit;   }
var new_sprite = "deployable";
var new_alpha = image_alpha;
var subimg = 0;
switch state {
    case -1:
        var blue_time = placement_alpha/deploy_speed*2;
        var new_state_time = state_timer - blue_time;
        new_alpha = state_timer > blue_time ? new_state_time * deploy_speed * 2 : 0;
        break;
    case 0:
        new_sprite = type == "ultimate" ? "hologram" : "portal";
        subimg = floor(get_gameplay_time()/9); // Iterate through the sprite.
        break;
}

if new_sprite != "" {    draw_sprite_ext(sprite_get(new_sprite), subimg, x, y, 1, 1, 0, c_white, new_alpha);  }
// draw_sprite_ext(sprite_get("shield_area"), 0, x-48, y-76, 1, 1, 0, c_white, new_alpha);
// draw_debug_text(x, y, "State: " + string(state));
// draw_debug_text(x-15, y-32, "Timer: " + string(state_timer));
