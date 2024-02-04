//article3_pre_draw         behind sprite

// draw_debug_text(x-32, y-48, "state = " + string(state));
// draw_debug_text(x-32, y-32, "index = " + string(array_find_index(player_id.turrets, id)));
// draw_debug_text(x-32, y-32, "free? " + string(free));
// draw_debug_text(x-32, y-32, "health = " + string(sentry_health));


if ("damage_cd" in self) && ("sentry_health" in self) {
    if damage_cd > 0 && (state != -1 && state != 2) {
        draw_sprite_ext(sprite_get("healthbar"), 0,x-19,y-32, ((sentry_max_health-sentry_health)/sentry_max_health)*38, 1, 0, sym_color0, 1); //78 is the width of the inner space
        draw_sprite(sprite_get("sentry_healthbar"), 0, x,y-32);
    }
}
// draw_debug_text(x,y-64,string(damage_cd));