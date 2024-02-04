// Beam Attack
set_attack_value(AT_JAB, AG_CATEGORY, 0);
set_attack_value(AT_JAB, AG_NUM_WINDOWS, 1);
set_attack_value(AT_JAB, AG_SPRITE, sprite_get("jab"));
//set_attack_value(AT_JAB, AG_HURTBOX_SPRITE, sprite_get("jab_hurt"));



///-------------Window
set_window_value(AT_JAB, 1, AG_WINDOW_TYPE, 9);
set_window_value(AT_JAB, 1, AG_WINDOW_LENGTH, 16);
set_window_value(AT_JAB, 1, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_JAB, 1, AG_WINDOW_ANIM_FRAME_START, 1);
set_window_value(AT_JAB, 1, AG_WINDOW_INVINCIBILITY, 2);
set_window_value(AT_JAB, 1, AG_WINDOW_HAS_SFX, 02);

// ----------- HitBox
set_num_hitboxes(AT_JAB, 1);

// Basic attributes
//set_hitbox_value(AT_JAB, 1, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_JAB, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 1, HG_WINDOW, 1);
set_hitbox_value(AT_JAB, 1, HG_WINDOW_CREATION_FRAME, 1);
set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 16);
set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 3);
set_hitbox_value(AT_JAB, 1, HG_PRIORITY, 2);

// Size and Shape
set_hitbox_value(AT_JAB, 1, HG_SHAPE, 1);
set_hitbox_value(AT_JAB, 1, HG_WIDTH, 256);
set_hitbox_value(AT_JAB, 1, HG_HEIGHT, 7);
set_hitbox_value(AT_JAB, 1, HG_HITBOX_X, 128);
set_hitbox_value(AT_JAB, 1, HG_HITBOX_Y, -31);

// Detection Disable
set_hitbox_value(AT_JAB, 1, HG_IGNORES_PROJECTILES, 1);
set_hitbox_value(AT_JAB, 1, HG_TECHABLE, 3);

// Disable Knockback and stun
set_hitbox_value(AT_JAB, 1, HG_FORCE_FLINCH, 0);
set_hitbox_value(AT_JAB, 1, HG_HITSTUN_MULTIPLIER, 0);
set_hitbox_value(AT_JAB, 1, HG_BASE_HITPAUSE, 0);
set_hitbox_value(AT_JAB, 1, HG_HITPAUSE_SCALING, 0);
set_hitbox_value(AT_JAB, 1, HG_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_JAB, 1, HG_KNOCKBACK_SCALING, 0);
set_hitbox_value(AT_JAB, 1, HG_FINAL_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_JAB, 1, HG_ANGLE, 45);
set_hitbox_value(AT_JAB, 1, HG_ANGLE_FLIPPER, 0);

set_hitbox_value(AT_JAB, 1, HG_VISUAL_EFFECT, 1);


