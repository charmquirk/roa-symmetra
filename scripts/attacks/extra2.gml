// set_attack_value(AT_EXTRA_2, AG_CATEGORY, 2);
// // set_attack_value(AT_EXTRA_2, AG_SPRITE, sprite_get("reload"));
// // set_attack_value(AT_EXTRA_2, AG_HURTBOX_SPRITE, sprite_get("reload_hurt"));
// set_attack_value(AT_EXTRA_2, AG_NUM_WINDOWS, 3);

// ///-------------Window

// // Startup
// set_window_value(AT_EXTRA_2, 1, AG_WINDOW_TYPE, 1);
// set_window_value(AT_EXTRA_2, 1, AG_WINDOW_LENGTH, 6);
// set_window_value(AT_EXTRA_2, 1, AG_WINDOW_ANIM_FRAMES, 1);
// set_window_value(AT_EXTRA_2, 1, AG_WINDOW_ANIM_FRAME_START, 0);

// // Deployment
// set_window_value(AT_EXTRA_2, 2, AG_WINDOW_TYPE, 1);
// set_window_value(AT_EXTRA_2, 2, AG_WINDOW_LENGTH, 2);
// set_window_value(AT_EXTRA_2, 2, AG_WINDOW_ANIM_FRAMES, 2);
// set_window_value(AT_EXTRA_2, 2, AG_WINDOW_ANIM_FRAME_START, 0);
// set_window_value(AT_EXTRA_2, 2, AG_WINDOW_HAS_SFX, 1);
// set_window_value(AT_EXTRA_2, 2, AG_WINDOW_SFX_FRAME, 0);
// // set_window_value(AT_EXTRA_2, 2, AG_WINDOW_SFX, sound_get("reload 1"));


// // Endlag
// set_window_value(AT_EXTRA_2, 3, AG_WINDOW_TYPE, 1);
// set_window_value(AT_EXTRA_2, 3, AG_WINDOW_LENGTH, 8);
// set_window_value(AT_EXTRA_2, 3, AG_WINDOW_ANIM_FRAMES, 1);
// set_window_value(AT_EXTRA_2, 3, AG_WINDOW_ANIM_FRAME_START, 0);

// //-----------Hitboxes
// Create a portal
set_attack_value(AT_EXTRA_2, AG_CATEGORY, 2);
set_attack_value(AT_EXTRA_2, AG_NUM_WINDOWS, 3);
set_attack_value(AT_EXTRA_2, AG_SPRITE, sprite_get("uspecial"));
set_attack_value(AT_EXTRA_2, AG_HURTBOX_SPRITE, sprite_get("uspecial_hurt"));

///-------------Window

// Startup
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_LENGTH, 6);
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_ANIM_FRAME_START, 0);

// Preview Placement
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_TYPE, 9);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_LENGTH, 2);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_ANIM_FRAME_START, 0);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_INVINCIBILITY, 2);

// Deployment
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_LENGTH, 8);
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_ANIM_FRAME_START, 0);