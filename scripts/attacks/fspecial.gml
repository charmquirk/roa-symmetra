set_attack_value(AT_FSPECIAL, AG_CATEGORY, 2);
set_attack_value(AT_FSPECIAL, AG_SPRITE, sprite_get("fspecial"));
set_attack_value(AT_FSPECIAL, AG_HURTBOX_SPRITE, sprite_get("fspecial_hurt"));
set_attack_value(AT_FSPECIAL, AG_NUM_WINDOWS, 3);

// Startup
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_LENGTH, 16);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_ANIM_FRAMES, 8);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_ANIM_FRAME_START, 0);

// Active   -   Preview
var new_window_type = has_rune_remote_place ? 9 : 1;
set_window_value(AT_FSPECIAL, 2, AG_WINDOW_TYPE, new_window_type);
set_window_value(AT_FSPECIAL, 2, AG_WINDOW_LENGTH, 12);
set_window_value(AT_FSPECIAL, 2, AG_WINDOW_ANIM_FRAMES, 6);
set_window_value(AT_FSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START, 8);

// Active   -   Deployment
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_ANIM_FRAMES, 6);
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_ANIM_FRAME_START, 8);
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_SFX_FRAME, 0);
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_SFX, sound_get("barrier_deploy"));

// Endlag
set_window_value(AT_FSPECIAL, 4, AG_WINDOW_LENGTH, 8);
set_window_value(AT_FSPECIAL, 4, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_FSPECIAL, 4, AG_WINDOW_ANIM_FRAME_START, 14);

//-----------Hitboxes

set_num_hitboxes(AT_FSPECIAL, 1);

set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW, 3);
set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 0);

//if no special attribute
set_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME, barrier_rate);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED, 2);
// set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_VSPEED);
// set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_HSPEED);
// set_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME);

// set_hitbox_value(AT_FSPECIAL, 1, HG_DAMAGE, 5);
// set_hitbox_value(AT_FSPECIAL, 1, HG_PRIORITY, 1);
// set_hitbox_value(AT_FSPECIAL, 1, HG_ANGLE, 270);
// set_hitbox_value(AT_FSPECIAL, 1, HG_BASE_KNOCKBACK, 4);
// set_hitbox_value(AT_FSPECIAL, 1, HG_KNOCKBACK_SCALING, .6);
// set_hitbox_value(AT_FSPECIAL, 1, HG_BASE_HITPAUSE, 12);
// set_hitbox_value(AT_FSPECIAL, 1, HG_HITPAUSE_SCALING, .4);
// set_hitbox_value(AT_FSPECIAL, 1, HG_VISUAL_EFFECT, 303);
// set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_GROUP, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_SPRITE, sprite_get("barrier"));
set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_X, 16);
set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_Y, -32);
set_hitbox_value(AT_FSPECIAL, 1, HG_WIDTH, 32);
set_hitbox_value(AT_FSPECIAL, 1, HG_HEIGHT, 128);
set_hitbox_value(AT_FSPECIAL, 1, HG_SHAPE, 1);

set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_MASK, -1);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_WALL_BEHAVIOR, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_GROUND_BEHAVIOR, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_ENEMY_BEHAVIOR, 1); // goes through everything
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_DOES_NOT_REFLECT, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_PARRY_STUN, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_PROJECTILE_UNBASHABLE, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_IGNORES_PROJECTILES, 0);
