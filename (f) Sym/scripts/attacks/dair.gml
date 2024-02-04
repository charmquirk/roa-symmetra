//dair.gml
set_attack_value(AT_DAIR, AG_CATEGORY, 1);
set_attack_value(AT_DAIR, AG_SPRITE, sprite_get("dair"));
set_attack_value(AT_DAIR, AG_HURTBOX_SPRITE, sprite_get("dair_hurt"));
set_attack_value(AT_DAIR, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_DAIR, AG_NUM_WINDOWS, 3);

//-----------Windows

// // Startup
// set_window_value(AT_DAIR, 1, AG_WINDOW_TYPE, 1);
// set_window_value(AT_DAIR, 1, AG_WINDOW_LENGTH, 6);
// set_window_value(AT_DAIR, 1, AG_WINDOW_ANIM_FRAMES, 1);
// set_window_value(AT_DAIR, 1, AG_WINDOW_ANIM_FRAME_START, 0);

// // Active
// set_window_value(AT_DAIR, 2, AG_WINDOW_TYPE, 1);
// set_window_value(AT_DAIR, 2, AG_WINDOW_LENGTH, 6);
// set_window_value(AT_DAIR, 2, AG_WINDOW_ANIM_FRAMES, 1);
// set_window_value(AT_DAIR, 2, AG_WINDOW_ANIM_FRAME_START, 0);


// // Endlag
// set_window_value(AT_DAIR, 3, AG_WINDOW_TYPE, 1);
// set_window_value(AT_DAIR, 3, AG_WINDOW_LENGTH, 2);
// set_window_value(AT_DAIR, 3, AG_WINDOW_ANIM_FRAMES, 1);
// set_window_value(AT_DAIR, 3, AG_WINDOW_ANIM_FRAME_START, 0);



// //-----------Hitboxes

// set_num_hitboxes(AT_DAIR, 1);

// set_hitbox_value(AT_DAIR, 1, HG_HITBOX_TYPE, 2);
// set_hitbox_value(AT_DAIR, 1, HG_WINDOW, 2);
// set_hitbox_value(AT_DAIR, 1, HG_WINDOW_CREATION_FRAME, 0);
// set_hitbox_value(AT_DAIR, 1, HG_LIFETIME, 90);
// set_hitbox_value(AT_DAIR, 1, HG_HITBOX_X, 24);
// set_hitbox_value(AT_DAIR, 1, HG_HITBOX_Y, -31);
// set_hitbox_value(AT_DAIR, 1, HG_WIDTH, 32);
// set_hitbox_value(AT_DAIR, 1, HG_HEIGHT, 32);
// set_hitbox_value(AT_DAIR, 1, HG_SHAPE, 2);
// set_hitbox_value(AT_DAIR, 1, HG_DAMAGE, 5);
// set_hitbox_value(AT_DAIR, 1, HG_PRIORITY, 1);
// set_hitbox_value(AT_DAIR, 1, HG_ANGLE, 270);
// set_hitbox_value(AT_DAIR, 1, HG_BASE_KNOCKBACK, 4);
// set_hitbox_value(AT_DAIR, 1, HG_KNOCKBACK_SCALING, .6);
// set_hitbox_value(AT_DAIR, 1, HG_BASE_HITPAUSE, 12);
// set_hitbox_value(AT_DAIR, 1, HG_HITPAUSE_SCALING, .4);
// set_hitbox_value(AT_DAIR, 1, HG_VISUAL_EFFECT, 303);
// set_hitbox_value(AT_DAIR, 1, HG_HITBOX_GROUP, 1);

// set_hitbox_value(AT_DAIR, 1, HG_PROJECTILE_SPRITE, sprite_get("seat"));
// set_hitbox_value(AT_DAIR, 1, HG_PROJECTILE_MASK, -1);
// set_hitbox_value(AT_DAIR, 1, HG_PROJECTILE_DESTROY_EFFECT, 0);
// set_hitbox_value(AT_DAIR, 1, HG_PROJECTILE_HSPEED, 0);
// set_hitbox_value(AT_DAIR, 1, HG_PROJECTILE_VSPEED, 8);
// set_hitbox_value(AT_DAIR, 1, HG_PROJECTILE_GRAVITY, 0.4);