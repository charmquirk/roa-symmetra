set_attack_value(AT_NAIR, AG_CATEGORY, 1);
set_attack_value(AT_NAIR, AG_SPRITE, sprite_get("nair"));
set_attack_value(AT_NAIR, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_NAIR, AG_HURTBOX_SPRITE, sprite_get("nair_hurt"));

// ----------------Windows
set_attack_value(AT_NAIR, AG_NUM_WINDOWS, 3);
// Start up
set_window_value(AT_NAIR, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_NAIR, 1, AG_WINDOW_LENGTH, 8);
set_window_value(AT_NAIR, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_NAIR, 1, AG_WINDOW_ANIM_FRAME_START, 1);

// Active
set_window_value(AT_NAIR, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_NAIR, 2, AG_WINDOW_LENGTH, 20);
set_window_value(AT_NAIR, 2, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_NAIR, 2, AG_WINDOW_ANIM_FRAME_START, 1);

// Endlag
set_window_value(AT_NAIR, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_NAIR, 3, AG_WINDOW_LENGTH, 4);
set_window_value(AT_NAIR, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_NAIR, 3, AG_WINDOW_ANIM_FRAME_START, 1);

//-----------------Hitboxes
set_num_hitboxes(AT_NAIR, 2);

// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_TYPE, 1);
// set_hitbox_value(AT_NAIR, 1, HG_WINDOW, 2);
// set_hitbox_value(AT_NAIR, 1, HG_WINDOW_CREATION_FRAME, 1);
// set_hitbox_value(AT_NAIR, 1, HG_LIFETIME, 6);
// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_X, 3);
// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_Y, -64);
// set_hitbox_value(AT_NAIR, 1, HG_WIDTH, 64);
// set_hitbox_value(AT_NAIR, 1, HG_HEIGHT, 24);
// set_hitbox_value(AT_NAIR, 1, HG_PRIORITY, 2);
// set_hitbox_value(AT_NAIR, 1, HG_SHAPE, 0);
// set_hitbox_value(AT_NAIR, 1, HG_DAMAGE, 6);
// set_hitbox_value(AT_NAIR, 1, HG_ANGLE, 100);
// set_hitbox_value(AT_NAIR, 1, HG_BASE_KNOCKBACK, 8);
// set_hitbox_value(AT_NAIR, 1, HG_KNOCKBACK_SCALING, 0.2);
// set_hitbox_value(AT_NAIR, 1, HG_BASE_HITPAUSE, 3);
// set_hitbox_value(AT_NAIR, 1, HG_HITPAUSE_SCALING, .4);
// set_hitbox_value(AT_NAIR, 1, HG_VISUAL_EFFECT, 303);
// set_hitbox_value(AT_NAIR, 1, HG_FORCE_FLINCH, 0);

// //right
// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_TYPE, 1);
// set_hitbox_value(AT_NAIR, 1, HG_WINDOW, 2);
// set_hitbox_value(AT_NAIR, 1, HG_WINDOW_CREATION_FRAME, 0);
// set_hitbox_value(AT_NAIR, 1, HG_LIFETIME, 6);
// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_X, 30);
// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_Y, -31);
// set_hitbox_value(AT_NAIR, 1, HG_WIDTH, 48);
// set_hitbox_value(AT_NAIR, 1, HG_HEIGHT, 32);
// set_hitbox_value(AT_NAIR, 1, HG_SHAPE, 0);
// set_hitbox_value(AT_NAIR, 1, HG_DAMAGE, 6);
// set_hitbox_value(AT_NAIR, 1, HG_PRIORITY, 1);
// set_hitbox_value(AT_NAIR, 1, HG_ANGLE, 20);
// // set_hitbox_value(AT_NAIR, 1, HG_ANGLE_FLIPPER, 30);
// set_hitbox_value(AT_NAIR, 1, HG_BASE_KNOCKBACK, 4);
// set_hitbox_value(AT_NAIR, 1, HG_KNOCKBACK_SCALING, .3);
// set_hitbox_value(AT_NAIR, 1, HG_BASE_HITPAUSE, 10);
// set_hitbox_value(AT_NAIR, 1, HG_HITPAUSE_SCALING, .8);
// set_hitbox_value(AT_NAIR, 1, HG_VISUAL_EFFECT, 303);
// set_hitbox_value(AT_NAIR, 1, HG_HITBOX_GROUP, 1);
// //left
// set_hitbox_value(AT_NAIR, 2, HG_HITBOX_TYPE, 1);
// set_hitbox_value(AT_NAIR, 2, HG_WINDOW, 2);
// set_hitbox_value(AT_NAIR, 2, HG_WINDOW_CREATION_FRAME, 0);
// set_hitbox_value(AT_NAIR, 2, HG_LIFETIME, 6);
// set_hitbox_value(AT_NAIR, 2, HG_HITBOX_X, -30);
// set_hitbox_value(AT_NAIR, 2, HG_HITBOX_Y, -31);
// set_hitbox_value(AT_NAIR, 2, HG_WIDTH, 48);
// set_hitbox_value(AT_NAIR, 2, HG_HEIGHT, 32);
// set_hitbox_value(AT_NAIR, 2, HG_SHAPE, 0);
// set_hitbox_value(AT_NAIR, 2, HG_DAMAGE, 6);
// set_hitbox_value(AT_NAIR, 2, HG_PRIORITY, 1);
// set_hitbox_value(AT_NAIR, 2, HG_ANGLE, 160);
// // set_hitbox_value(AT_NAIR, 2, HG_ANGLE_FLIPPER, 30);
// set_hitbox_value(AT_NAIR, 2, HG_BASE_KNOCKBACK, 4);
// set_hitbox_value(AT_NAIR, 2, HG_KNOCKBACK_SCALING, .3);
// set_hitbox_value(AT_NAIR, 2, HG_BASE_HITPAUSE, 10);
// set_hitbox_value(AT_NAIR, 2, HG_HITPAUSE_SCALING, .8);
// set_hitbox_value(AT_NAIR, 2, HG_VISUAL_EFFECT, 303);
// set_hitbox_value(AT_NAIR, 2, HG_HITBOX_GROUP, 1);

set_hitbox_value(AT_NAIR, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_NAIR, 1, HG_WINDOW, 2);
set_hitbox_value(AT_NAIR, 1, HG_WINDOW_CREATION_FRAME, 0);
set_hitbox_value(AT_NAIR, 1, HG_LIFETIME, 6);
set_hitbox_value(AT_NAIR, 1, HG_HITBOX_X, 0);
set_hitbox_value(AT_NAIR, 1, HG_HITBOX_Y, -16);
set_hitbox_value(AT_NAIR, 1, HG_WIDTH, 48);
set_hitbox_value(AT_NAIR, 1, HG_HEIGHT, 32);
set_hitbox_value(AT_NAIR, 1, HG_SHAPE, 0);
set_hitbox_value(AT_NAIR, 1, HG_DAMAGE, 6);
set_hitbox_value(AT_NAIR, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_NAIR, 1, HG_ANGLE, 20);
// set_hitbox_value(AT_NAIR, 1, HG_ANGLE_FLIPPER, 30);
set_hitbox_value(AT_NAIR, 1, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_NAIR, 1, HG_KNOCKBACK_SCALING, .8);
set_hitbox_value(AT_NAIR, 1, HG_BASE_HITPAUSE, 10);
set_hitbox_value(AT_NAIR, 1, HG_HITPAUSE_SCALING, .8);
set_hitbox_value(AT_NAIR, 1, HG_VISUAL_EFFECT, 303);
set_hitbox_value(AT_NAIR, 1, HG_HITBOX_GROUP, 1);

set_hitbox_value(AT_NAIR, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_NAIR, 2, HG_WINDOW, 2);
set_hitbox_value(AT_NAIR, 2, HG_WINDOW_CREATION_FRAME, 0);
set_hitbox_value(AT_NAIR, 2, HG_LIFETIME, 6);
set_hitbox_value(AT_NAIR, 2, HG_HITBOX_X, 0);
set_hitbox_value(AT_NAIR, 2, HG_HITBOX_Y, -48);
set_hitbox_value(AT_NAIR, 2, HG_WIDTH, 48);
set_hitbox_value(AT_NAIR, 2, HG_HEIGHT, 32);
set_hitbox_value(AT_NAIR, 2, HG_SHAPE, 0);
set_hitbox_value(AT_NAIR, 2, HG_DAMAGE, 6);
set_hitbox_value(AT_NAIR, 2, HG_PRIORITY, 1);
set_hitbox_value(AT_NAIR, 2, HG_ANGLE, 160);
// set_hitbox_value(AT_NAIR, 1, HG_ANGLE_FLIPPER, 30);
set_hitbox_value(AT_NAIR, 2, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_NAIR, 2, HG_KNOCKBACK_SCALING, .8);
set_hitbox_value(AT_NAIR, 2, HG_BASE_HITPAUSE, 10);
set_hitbox_value(AT_NAIR, 2, HG_HITPAUSE_SCALING, .8);
set_hitbox_value(AT_NAIR, 2, HG_VISUAL_EFFECT, 303);
set_hitbox_value(AT_NAIR, 2, HG_HITBOX_GROUP, 1);