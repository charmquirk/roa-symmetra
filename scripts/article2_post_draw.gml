//article2_post_draw        in front of sprite
var teleporter_sprite = "";
var teleporter_opacity = 0;
switch (state) {
    case 2: // Destroying
    case -1: // Previewing
        teleporter_opacity = free ? 0.2 : get_gameplay_time()/6;
        teleporter_sprite = type == "ultimate" ? "teleporter_preview" : "spawn_point_preview";
        draw_sprite_ext(sprite_get(teleporter_sprite), 0, x,y, 1, 1, 0, c_white, teleporter_opacity);
        break;
    
    case 0: // Idle
    case 1: // Active
        var teleporter_opacity = 1;
        var teleporter_sprite = "deployable";
        draw_sprite_ext(sprite_get(teleporter_sprite), 0, x,y, 1, 1, 0, c_white, teleporter_opacity);
        break;
}
