// nspecial
// Orb charging neutral special
set_attack_value(AT_NSPECIAL, AG_CATEGORY, 2);
set_attack_value(AT_NSPECIAL, AG_SPRITE, sprite_get("nspecial"));
set_attack_value(AT_NSPECIAL, AG_HURTBOX_SPRITE, sprite_get("nspecial_hurt"));
set_attack_value(AT_NSPECIAL, AG_NUM_WINDOWS, 3);
set_attack_value(AT_NSPECIAL, AG_HAS_LANDING_LAG, 4);
set_attack_value(AT_NSPECIAL, AG_OFF_LEDGE, 1);


// Startup  -   Arming your weapon. Variables reset here.
set_window_value(AT_NSPECIAL, 1, AG_WINDOW_LENGTH, 2);
set_window_value(AT_NSPECIAL, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_NSPECIAL, 1, AG_WINDOW_ANIM_FRAME_START, 0);

// Charging the orb
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_LENGTH, 8);
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_ANIM_FRAMES, 8);
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START, 0);
// set_window_value(AT_NSPECIAL, 2, AG_WINDOW_HAS_SFX, 1);
// set_window_value(AT_NSPECIAL, 2, AG_WINDOW_SFX_FRAME, 1);
// set_window_value(AT_NSPECIAL, 2, AG_WINDOW_SFX, sound_get("orb charging 1"));

// Holding
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_TYPE, 9); // Looping window
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_LENGTH, 8);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_ANIM_FRAMES, 8);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_ANIM_FRAME_START, 8);

// Release & Endlag
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_LENGTH, 4);
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_ANIM_FRAME_START, 16);
// set_window_value(AT_NSPECIAL, 4, AG_WINDOW_HAS_SFX, 1);
// set_window_value(AT_NSPECIAL, 4, AG_WINDOW_SFX_FRAME, 0);
// set_window_value(AT_NSPECIAL, 4, AG_WINDOW_SFX, sound_get("orb_shot2"));

set_num_hitboxes(AT_NSPECIAL, 2);

// Mini orb
set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW, 4);
set_hitbox_value(AT_NSPECIAL, 1, HG_WINDOW_CREATION_FRAME, 99);     // Disabled by default.
set_hitbox_value(AT_NSPECIAL, 1, HG_LIFETIME, 120);
set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_X, 20);
set_hitbox_value(AT_NSPECIAL, 1, HG_HITBOX_Y, -34);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_HSPEED, mini_orb_speed);
set_hitbox_value(AT_NSPECIAL, 1, HG_PRIORITY, 3);
set_hitbox_value(AT_NSPECIAL, 1, HG_DAMAGE, mini_orb_damage); // Damage
set_hitbox_value(AT_NSPECIAL, 1, HG_ANGLE, 90);
set_hitbox_value(AT_NSPECIAL, 1, HG_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_NSPECIAL, 1, HG_BASE_HITPAUSE, 0);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_PARRY_STUN, 1);
set_hitbox_value(AT_NSPECIAL, 1, HG_EXTENDED_PARRY_STUN, 1);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_PARRY_STUN, false);
set_hitbox_value(AT_NSPECIAL, 1, HG_VISUAL_EFFECT, 3);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_SPRITE, sprite_get("orb_uncharged"));
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_MASK, sprite_get("orb_uncharged"));
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_COLLISION_SPRITE, sprite_get("orb_mask"));
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_ANIM_SPEED, 1);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_DESTROY_EFFECT, 13);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_GROUND_BEHAVIOR, 0);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_WALL_BEHAVIOR, 0);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_ENEMY_BEHAVIOR, 0);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_IS_TRANSCENDENT, true);
set_hitbox_value(AT_NSPECIAL, 1, HG_PROJECTILE_DOES_NOT_REFLECT, true);
set_hitbox_value(AT_NSPECIAL, 1, HG_IGNORES_PROJECTILES, 1);

// Big orb
set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW, 4);
set_hitbox_value(AT_NSPECIAL, 2, HG_WINDOW_CREATION_FRAME, 99); // Disabled by default.
var new_big_lifetime = has_rune_orb_scaling ? 360 : 120;
set_hitbox_value(AT_NSPECIAL, 2, HG_LIFETIME, new_big_lifetime);
set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_X, 20);
set_hitbox_value(AT_NSPECIAL, 2, HG_HITBOX_Y, -34);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_HSPEED, big_orb_speed);
set_hitbox_value(AT_NSPECIAL, 2, HG_PRIORITY, 3);
set_hitbox_value(AT_NSPECIAL, 2, HG_DAMAGE, big_orb_damage);
set_hitbox_value(AT_NSPECIAL, 2, HG_ANGLE, 90);
set_hitbox_value(AT_NSPECIAL, 2, HG_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_NSPECIAL, 2, HG_BASE_HITPAUSE, 0);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_PARRY_STUN, 1);
set_hitbox_value(AT_NSPECIAL, 2, HG_EXTENDED_PARRY_STUN, 1);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_PARRY_STUN, false);
set_hitbox_value(AT_NSPECIAL, 2, HG_VISUAL_EFFECT, 3);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_SPRITE, sprite_get("orb_charged"));
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_MASK, sprite_get("orb_charged"));
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_COLLISION_SPRITE, sprite_get("orb_mask"));
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_ANIM_SPEED, 1);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_DESTROY_EFFECT, 13);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_GROUND_BEHAVIOR, -1);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_WALL_BEHAVIOR, 0);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_ENEMY_BEHAVIOR, 1);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_IS_TRANSCENDENT, true);
set_hitbox_value(AT_NSPECIAL, 2, HG_PROJECTILE_DOES_NOT_REFLECT, true);
set_hitbox_value(AT_NSPECIAL, 2, HG_IGNORES_PROJECTILES, 1);