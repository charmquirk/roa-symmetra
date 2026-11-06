//article2_post_draw        in front of sprite

var teleporter_sprite = "";
var teleporter_opacity = 0;
switch (state) {
    case 2: // Destroying
    case -1: // Previewing
        teleporter_opacity = free ? 0.2 : get_gameplay_time()/6;
        teleporter_sprite = type == "ultimate" ? "spawn_point_preview" : "teleporter_preview";
        draw_sprite_ext(sprite_get(teleporter_sprite), 0, x,y, 1, 1, 0, c_white, teleporter_opacity);
        break;
    
    case 0: // Idle
    case 1: // Active
        var teleporter_opacity = 1;
        var teleporter_sprite = "deployable";
        draw_sprite_ext(sprite_get(teleporter_sprite), 0, x,y, 1, 1, 0, c_white, teleporter_opacity);
        break;
}


if !("state" in self) { exit;   }
var new_sprite = "";
var new_alpha = image_alpha;
switch state {
    case -1:
        new_sprite = "deployable";
        var blue_time = placement_alpha/deploy_speed*2;
        var new_state_time = state_timer - blue_time;
        new_alpha = state_timer > blue_time ? new_state_time * deploy_speed * 2 : 0;
        break;
    case 0:
        new_sprite = type == "ultimate" ? "spawn_point_hologram" : "teleporter_portal";
        break;
    // case 1:
    //     new_sprite = "sentry_active"
}

if new_sprite != "" {    draw_sprite_ext(sprite_get(new_sprite), -1, x, y, 1, 1, 0, c_white, new_alpha);  }