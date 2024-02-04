// Beam Attack
set_attack_value(AT_JAB, AG_SPRITE, sprite_get("jab"));
set_attack_value(AT_JAB, AG_HURTBOX_SPRITE, sprite_get("jab_hurt"));

set_attack_value(AT_JAB, AG_WINDOW_TYPE, 0);
set_attack_value(AT_JAB, AG_WINDOW_LENGTH, 1);

// Animation
set_attack_value(AT_JAB, AG_WINDOW_ANIM_FRAMES, 1);
set_attack_value(AT_JAB, AG_WINDOW_ANIM_FRAME_START, 1);

set_attack_value(AT_JAB, AG_WINDOW_CANCEL_TYPE, 0);

// Slows movement while firing
set_attack_value(AT_JAB, AG_WINDOW_HSPEED_TYPE, 0);
set_attack_value(AT_JAB, AG_WINDOW_HSPEED, 1);

// ----------- HitBox

// Basic attributes
set_attack_value(AT_JAB, HG_DAMAGE, 3);
set_attack_value(AT_JAB, HG_PRIORITY, 2);

// Detection Disable
set_attack_value(AT_JAB, HG_IGNORES_PROJECTILES, 1);
set_attack_value(AT_JAB, HG_TECHABLE, 3);

// Disable Knockback and stun
set_attack_value(AT_JAB, HG_BASE_HITPAUSE, 0);
set_attack_value(AT_JAB, HG_BASE_KNOCKBACK, 0);
set_attack_value(AT_JAB, HG_ANGLE, 0);
set_attack_value(AT_JAB, HG_ANGLE_FLIPPER, 0);

// Size and Shape
set_attack_value(AT_JAB, HG_SHAPE, 1);
set_attack_value(AT_JAB, HG_WIDTH, 256);
set_attack_value(AT_JAB, HG_HEIGHT, 25);
set_attack_value(AT_JAB, HG_HITBOX_X, 0);
set_attack_value(AT_JAB, HG_HITBOX_Y, 13);