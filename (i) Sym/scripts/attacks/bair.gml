// Dirty Look
set_attack_value(AT_BAIR, AG_CATEGORY, 1);
set_attack_value(AT_BAIR, AG_SPRITE, sprite_get("bair"));
set_attack_value(AT_BAIR, AG_HURTBOX_SPRITE, sprite_get("bair_hurt"));
set_attack_value(AT_BAIR, AG_NUM_WINDOWS, 4);
set_attack_value(AT_BAIR, AG_HAS_LANDING_LAG, 1);


// ----------------Windows
// Wind-up
set_window_value(AT_BAIR, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_BAIR, 1, AG_WINDOW_LENGTH, 8);
set_window_value(AT_BAIR, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_BAIR, 1, AG_WINDOW_ANIM_FRAME_START, 1);
set_window_value(AT_BAIR, 1, AG_WINDOW_HAS_SFX, 0);

// Unwind
set_window_value(AT_BAIR, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_BAIR, 2, AG_WINDOW_LENGTH, 4);
set_window_value(AT_BAIR, 2, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_BAIR, 2, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_BAIR, 2, AG_WINDOW_HAS_SFX, 0);
//set_window_value(AT_BAIR, 2, AG_WINDOW_VSPEED_TYPE, 1);
//set_window_value(AT_BAIR, 2, AG_WINDOW_VSPEED, 0);

// Sustain
set_window_value(AT_BAIR, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_BAIR, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_BAIR, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_BAIR, 3, AG_WINDOW_ANIM_FRAME_START, 4);
set_window_value(AT_BAIR, 3, AG_WINDOW_HAS_SFX, 0);

// Endlag
set_window_value(AT_BAIR, 4, AG_WINDOW_TYPE, 1);
set_window_value(AT_BAIR, 4, AG_WINDOW_LENGTH, 2);
set_window_value(AT_BAIR, 4, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_BAIR, 4, AG_WINDOW_ANIM_FRAME_START, 5);
set_window_value(AT_BAIR, 4, AG_WINDOW_HAS_SFX, 0);

//-----------------Hitboxes
set_num_hitboxes(AT_BAIR, 2)

//Sweet-spot
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_BAIR, 1, HG_WINDOW, 2);
set_hitbox_value(AT_BAIR, 1, HG_WINDOW_CREATION_FRAME, 2);
set_hitbox_value(AT_BAIR, 1, HG_LIFETIME, 8);
set_hitbox_value(AT_BAIR, 1, HG_DAMAGE, 1);
set_hitbox_value(AT_BAIR, 1, HG_PRIORITY, 3);
set_hitbox_value(AT_BAIR, 1, HG_SHAPE, 2);
set_hitbox_value(AT_BAIR, 1, HG_WIDTH, 24);
set_hitbox_value(AT_BAIR, 1, HG_HEIGHT, 24);
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_X, -20);
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_Y, -42);
set_hitbox_value(AT_BAIR, 1, HG_IGNORES_PROJECTILES, 0);
set_hitbox_value(AT_BAIR, 1, HG_TECHABLE, 3);


set_hitbox_value(AT_BAIR, 1, HG_FORCE_FLINCH, 0);
set_hitbox_value(AT_BAIR, 1, HG_HITSTUN_MULTIPLIER, 1);
set_hitbox_value(AT_BAIR, 1, HG_BASE_HITPAUSE, 4);
set_hitbox_value(AT_BAIR, 1, HG_HITPAUSE_SCALING, 2);
set_hitbox_value(AT_BAIR, 1, HG_BASE_KNOCKBACK, 0.5);
set_hitbox_value(AT_BAIR, 1, HG_KNOCKBACK_SCALING, 1.5);
set_hitbox_value(AT_BAIR, 1, HG_FINAL_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_BAIR, 1, HG_ANGLE, 160);
set_hitbox_value(AT_BAIR, 1, HG_ANGLE_FLIPPER, 0);
set_hitbox_value(AT_BAIR, 1, HG_HIT_SFX, asset_get("sfx_absa_harderhit"));

set_hitbox_value(AT_BAIR, 1, HG_VISUAL_EFFECT, 19);

//Sour-spot
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_BAIR, 2, HG_WINDOW, 2);
set_hitbox_value(AT_BAIR, 2, HG_WINDOW_CREATION_FRAME, 0);
set_hitbox_value(AT_BAIR, 2, HG_LIFETIME, 4);
set_hitbox_value(AT_BAIR, 2, HG_DAMAGE, 2);
set_hitbox_value(AT_BAIR, 2, HG_PRIORITY, 2);
set_hitbox_value(AT_BAIR, 2, HG_SHAPE, 0);
set_hitbox_value(AT_BAIR, 2, HG_WIDTH, 22);
set_hitbox_value(AT_BAIR, 2, HG_HEIGHT, 22);
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_X, -5);
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_Y, -43);
set_hitbox_value(AT_BAIR, 2, HG_IGNORES_PROJECTILES, 0);
set_hitbox_value(AT_BAIR, 2, HG_TECHABLE, 3);


set_hitbox_value(AT_BAIR, 2, HG_FORCE_FLINCH, 0);
set_hitbox_value(AT_BAIR, 2, HG_HITSTUN_MULTIPLIER, 0.4);
set_hitbox_value(AT_BAIR, 2, HG_BASE_HITPAUSE, 0.4);
set_hitbox_value(AT_BAIR, 2, HG_HITPAUSE_SCALING, 0);
set_hitbox_value(AT_BAIR, 2, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_BAIR, 2, HG_KNOCKBACK_SCALING, 0);
set_hitbox_value(AT_BAIR, 2, HG_FINAL_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_BAIR, 2, HG_ANGLE, 170);
set_hitbox_value(AT_BAIR, 2, HG_ANGLE_FLIPPER, 0);

set_hitbox_value(AT_BAIR, 2, HG_VISUAL_EFFECT, 311);
//set_hitbox_value(AT_BAIR, 1, HG_HIT_SFX, asset_get("sfx_absa_orb_miss"));