//article2_post_draw        in front of sprite
switch (state) {
    case -1:
        if type == "entrance" || type == "exit" {
            if !free { draw_sprite_ext(sprite_get("teleporter_pad_preview"), 0, x,y, 1, 1, 0, c_white, get_gameplay_time()/6); }
            else { draw_sprite_ext(sprite_get("teleporter_pad_preview"), 0, x,y, 1, 1, 0, c_white, 0.2); }
        }
        if type == "ultimate" {
            if !free { draw_sprite_ext(sprite_get("teleporter_ultimate_preview"), 0, x,y, 1, 1, 0, c_white, get_gameplay_time()/6); }
            else { draw_sprite_ext(sprite_get("teleporter_ultimate_preview"), 0, x,y, 1, 1, 0, c_white, 0.2); }
        }
        
        
        break;
}