// Beam Attack
set_attack_value(AT_JAB, AG_CATEGORY,2);
set_attack_value(AT_JAB, AG_NUM_WINDOWS, 3);
set_attack_value(AT_JAB, AG_OFF_LEDGE, 1);
set_attack_value(AT_JAB, AG_SPRITE, sprite_get("jab"));
//set_attack_value(AT_JAB, AG_HURTBOX_SPRITE, sprite_get("jab_hurt"));



///-------------Window

// Startup
set_window_value(AT_JAB, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_JAB, 1, AG_WINDOW_LENGTH, 2);
set_window_value(AT_JAB, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_JAB, 1, AG_WINDOW_ANIM_FRAME_START, 0);


// Active
set_window_value(AT_JAB, 2, AG_WINDOW_TYPE, 9);
set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 2);
set_window_value(AT_JAB, 2, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_JAB, 2, AG_WINDOW_ANIM_FRAME_START, 1);
set_window_value(AT_JAB, 2, AG_WINDOW_INVINCIBILITY, 2);

// Endlag
set_window_value(AT_JAB, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_JAB, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_JAB, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_JAB, 3, AG_WINDOW_ANIM_FRAME_START, 0);


// ----------- HitBox
// set_num_hitboxes(AT_JAB, 1);

// set_hitbox_value(AT_JAB, 1, HG_HITBOX_TYPE, 2);
// set_hitbox_value(AT_JAB, 1, HG_WINDOW, 2);
// set_hitbox_value(AT_JAB, 1, HG_WINDOW_CREATION_FRAME, 0);
// set_hitbox_value(AT_JAB, 1, HG_LIFETIME, charge_length);
// set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 1);
// set_hitbox_value(AT_JAB, 1, HG_PRIORITY, 2);
// set_hitbox_value(AT_JAB, 1, HG_SHAPE, 0);
// set_hitbox_value(AT_JAB, 1, HG_WIDTH, 17);
// set_hitbox_value(AT_JAB, 1, HG_HEIGHT, 17);
// set_hitbox_value(AT_JAB, 1, HG_HITBOX_X, 0);
// set_hitbox_value(AT_JAB, 1, HG_HITBOX_Y, -32);
// // Disable Detection, Knockback and stun
// set_hitbox_value(AT_JAB, 1, HG_IGNORES_PROJECTILES, 1);
// set_hitbox_value(AT_JAB, 1, HG_TECHABLE, 3);
// set_hitbox_value(AT_JAB, 1, HG_FORCE_FLINCH, 0);
// set_hitbox_value(AT_JAB, 1, HG_HITSTUN_MULTIPLIER, 0);
// set_hitbox_value(AT_JAB, 1, HG_BASE_HITPAUSE, 0);
// set_hitbox_value(AT_JAB, 1, HG_HITPAUSE_SCALING, 0);
// set_hitbox_value(AT_JAB, 1, HG_BASE_KNOCKBACK, 0);
// set_hitbox_value(AT_JAB, 1, HG_KNOCKBACK_SCALING, 0);
// set_hitbox_value(AT_JAB, 1, HG_FINAL_BASE_KNOCKBACK, 0);
// set_hitbox_value(AT_JAB, 1, HG_ANGLE, 45);
// set_hitbox_value(AT_JAB, 1, HG_ANGLE_FLIPPER, 0);

// set_hitbox_value(AT_JAB, 1, HG_VISUAL_EFFECT, 1);
// set_hitbox_value(AT_JAB, 1, HG_PROJECTILE_SPRITE, asset_get("empty_sprite")); // sprite_get("beam_tip"));
// set_hitbox_value(AT_JAB, 1, HG_PROJECTILE_MASK, -1);
// set_hitbox_value(AT_JAB, 1, HG_PROJECTILE_ENEMY_BEHAVIOR, 0);
// set_hitbox_value(AT_JAB, 1, HG_PROJECTILE_WALL_BEHAVIOR, 2);
// set_hitbox_value(AT_JAB, 1, HG_PROJECTILE_GROUND_BEHAVIOR, 2);
// set_hitbox_value(AT_JAB, 1, HG_PROJECTILE_IS_TRANSCENDENT, true);
