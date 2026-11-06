//other_post_draw

if is_healing_target || is_damage_target {
    shader_start();
    var subimg = 0;//floor(get_gameplay_time()/9); // Iterate through the sprite.
    var midline = y - char_height/2;
    if is_healing_target {  draw_sprite_ext(sprite_get("cfx_heal"), subimg, x, midline, 1, 1, spr_dir, c_white, 1); }
    if is_damage_target {   draw_sprite_ext(sprite_get("cfx_sentry_fire"), subimg, x, midline, 1, 1, spr_dir, c_white, 1);  }
    shader_end();
}