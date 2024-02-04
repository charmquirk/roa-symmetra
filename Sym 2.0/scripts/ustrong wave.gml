// Dancing orb spawn up strong
set_attack_value(AT_USTRONG, AG_SPRITE, sprite_get("ustrong"));
set_attack_value(AT_USTRONG, AG_HURTBOX_SPRITE, sprite_get("ustrong_hurt"));
set_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW, 1);
set_attack_value(AT_USTRONG, AG_NUM_WINDOWS, 4);

// Startup
set_window_value(AT_USTRONG, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_USTRONG, 1, AG_WINDOW_LENGTH, 6);
set_window_value(AT_USTRONG, 1, AG_WINDOW_ANIM_FRAMES, 1);

// Charging Window
set_window_value(AT_USTRONG, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_USTRONG, 2, AG_WINDOW_LENGTH, 18);
set_window_value(AT_USTRONG, 2, AG_WINDOW_ANIM_FRAMES, 1);

// Active strong attack
set_window_value(AT_USTRONG, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_USTRONG, 3, AG_WINDOW_LENGTH, 6);
set_window_value(AT_USTRONG, 3, AG_WINDOW_ANIM_FRAMES, 1);

// End lag
set_window_value(AT_USTRONG, 4, AG_WINDOW_TYPE, 1);
set_window_value(AT_USTRONG, 4, AG_WINDOW_LENGTH, 5);
set_window_value(AT_USTRONG, 4, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_USTRONG, 4, AG_WINDOW_HAS_WHIFFLAG, 12);

//-----------Windows

set_num_hitboxes(AT_USTRONG, 4);

// Weak hit 1
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_USTRONG, 1, HG_WINDOW, 2);
set_hitbox_value(AT_USTRONG, 1, HG_WINDOW_CREATION_FRAME, 0);
set_hitbox_value(AT_USTRONG, 1, HG_LIFETIME, 6);
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_X, 0);
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_Y, -32);
set_hitbox_value(AT_USTRONG, 1, HG_WIDTH, 81);
set_hitbox_value(AT_USTRONG, 1, HG_HEIGHT, 64);
set_hitbox_value(AT_USTRONG, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_USTRONG, 1, HG_SHAPE, 2);
set_hitbox_value(AT_USTRONG, 1, HG_DAMAGE, 2);
set_hitbox_value(AT_USTRONG, 1, HG_ANGLE, 80);
set_hitbox_value(AT_USTRONG, 1, HG_ANGLE_FLIPPER, 9);
set_hitbox_value(AT_USTRONG, 1, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_USTRONG, 1, HG_KNOCKBACK_SCALING, 0.1);
set_hitbox_value(AT_USTRONG, 1, HG_BASE_HITPAUSE, 4);
set_hitbox_value(AT_USTRONG, 1, HG_HITPAUSE_SCALING, .4);
set_hitbox_value(AT_USTRONG, 1, HG_VISUAL_EFFECT, 303);
set_hitbox_value(AT_USTRONG, 1, HG_FORCE_FLINCH, 0);
set_hitbox_value(AT_USTRONG, 1, HG_GROUNDEDNESS, 0);
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_GROUP, 1);

// Weak hit 2
set_hitbox_value(AT_USTRONG, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_USTRONG, 2, HG_WINDOW, 2);
set_hitbox_value(AT_USTRONG, 2, HG_WINDOW_CREATION_FRAME, 6);
set_hitbox_value(AT_USTRONG, 2, HG_LIFETIME, 6);
set_hitbox_value(AT_USTRONG, 2, HG_HITBOX_X, 0);
set_hitbox_value(AT_USTRONG, 2, HG_HITBOX_Y, -48);
set_hitbox_value(AT_USTRONG, 2, HG_WIDTH, 81);
set_hitbox_value(AT_USTRONG, 2, HG_HEIGHT, 64);
set_hitbox_value(AT_USTRONG, 2, HG_PRIORITY, 1);
set_hitbox_value(AT_USTRONG, 2, HG_SHAPE, 2);
set_hitbox_value(AT_USTRONG, 2, HG_DAMAGE, 2);
set_hitbox_value(AT_USTRONG, 2, HG_ANGLE, 90);
set_hitbox_value(AT_USTRONG, 2, HG_ANGLE_FLIPPER, 9);
set_hitbox_value(AT_USTRONG, 2, HG_BASE_KNOCKBACK, 3);
set_hitbox_value(AT_USTRONG, 2, HG_KNOCKBACK_SCALING, 0.1);
set_hitbox_value(AT_USTRONG, 2, HG_BASE_HITPAUSE, 4);
set_hitbox_value(AT_USTRONG, 2, HG_HITPAUSE_SCALING, .4);
set_hitbox_value(AT_USTRONG, 2, HG_VISUAL_EFFECT, 303);
set_hitbox_value(AT_USTRONG, 2, HG_FORCE_FLINCH, 0);
set_hitbox_value(AT_USTRONG, 2, HG_GROUNDEDNESS, 0);
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_GROUP, 2);

// Weak hit that orientates the opponent into the final blast
set_hitbox_value(AT_USTRONG, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_USTRONG, 3, HG_WINDOW, 2);
set_hitbox_value(AT_USTRONG, 3, HG_WINDOW_CREATION_FRAME, 12);
set_hitbox_value(AT_USTRONG, 3, HG_LIFETIME, 6);
set_hitbox_value(AT_USTRONG, 3, HG_HITBOX_X, 0);
set_hitbox_value(AT_USTRONG, 3, HG_HITBOX_Y, -64);
set_hitbox_value(AT_USTRONG, 3, HG_WIDTH, 81);
set_hitbox_value(AT_USTRONG, 3, HG_HEIGHT, 64);
set_hitbox_value(AT_USTRONG, 3, HG_PRIORITY, 5);
set_hitbox_value(AT_USTRONG, 3, HG_SHAPE, 2);
set_hitbox_value(AT_USTRONG, 3, HG_DAMAGE, 3);
set_hitbox_value(AT_USTRONG, 3, HG_ANGLE, 90);
set_hitbox_value(AT_USTRONG, 1, HG_ANGLE_FLIPPER, 9);
set_hitbox_value(AT_USTRONG, 3, HG_BASE_KNOCKBACK, 3);
set_hitbox_value(AT_USTRONG, 3, HG_KNOCKBACK_SCALING, 0.1);
set_hitbox_value(AT_USTRONG, 3, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_USTRONG, 3, HG_HITPAUSE_SCALING, .4);
set_hitbox_value(AT_USTRONG, 3, HG_VISUAL_EFFECT, 303);
set_hitbox_value(AT_USTRONG, 3, HG_FORCE_FLINCH, 1);
set_hitbox_value(AT_USTRONG, 3, HG_GROUNDEDNESS, 0);
set_hitbox_value(AT_USTRONG, 3, HG_HITBOX_GROUP, 3);

// Strong hit / Final Blast
set_hitbox_value(AT_USTRONG, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_USTRONG, 4, HG_WINDOW, 3);
set_hitbox_value(AT_USTRONG, 4, HG_WINDOW_CREATION_FRAME, 3);
set_hitbox_value(AT_USTRONG, 4, HG_LIFETIME, 6);
set_hitbox_value(AT_USTRONG, 4, HG_HITBOX_X, 0);
set_hitbox_value(AT_USTRONG, 4, HG_HITBOX_Y, -96);
set_hitbox_value(AT_USTRONG, 4, HG_WIDTH, 63);
set_hitbox_value(AT_USTRONG, 4, HG_HEIGHT, 64);
set_hitbox_value(AT_USTRONG, 4, HG_PRIORITY, 1);
set_hitbox_value(AT_USTRONG, 4, HG_SHAPE, 2);
set_hitbox_value(AT_USTRONG, 4, HG_DAMAGE, 8);
set_hitbox_value(AT_USTRONG, 4, HG_ANGLE, 90);
set_hitbox_value(AT_USTRONG, 4, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_USTRONG, 4, HG_KNOCKBACK_SCALING, 1);
set_hitbox_value(AT_USTRONG, 4, HG_BASE_HITPAUSE, 15);
set_hitbox_value(AT_USTRONG, 4, HG_HITPAUSE_SCALING, .4);
set_hitbox_value(AT_USTRONG, 4, HG_VISUAL_EFFECT, 197);
set_hitbox_value(AT_USTRONG, 4, HG_FORCE_FLINCH, 1);
set_hitbox_value(AT_USTRONG, 4, HG_GROUNDEDNESS, 0);
set_hitbox_value(AT_USTRONG, 4, HG_HITBOX_GROUP, 4);