// dspecial.gml
set_attack_value(AT_DSPECIAL, AG_CATEGORY, 2);
set_attack_value(AT_DSPECIAL, AG_NUM_WINDOWS, 3);
set_attack_value(AT_DSPECIAL, AG_SPRITE, sprite_get("dspecial"));
set_attack_value(AT_DSPECIAL, AG_HURTBOX_SPRITE, sprite_get("dspecial_hurt"));

///-------------Window
// Startup
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_LENGTH, 2);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_ANIM_FRAME_START, 0);


// Active

if has_rune("F") { //hold to place
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_TYPE, 9);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_LENGTH, 6);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAMES, 1);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START, 1);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_INVINCIBILITY, 2);
}
else { //instant placement
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_TYPE, 1);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_LENGTH, 6);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAMES, 1);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START, 1);
    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_INVINCIBILITY, 2);
}


// Endlag
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_ANIM_FRAME_START, 0);
