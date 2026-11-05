//article3_init

//
//  Sentry Turret
//

// Sprite and direction


image_alpha = 1;
sprite_index = asset_get("empty_sprite");
mask_index = free ? sprite_get("sentry_aerial_mask") : sprite_get("sentry_grounded_mask");
uses_shader = true;
can_be_grounded = true;
ignores_walls = false;
is_weak_turret = false;
is_healing = false;

// Aiming
sentry_target = noone;
sentry_angle = 0;
sentry_range = is_weak_turret ? 32*5 : 32*8;
t_dist = 0;     // Target distance
t_ang = 0;      // Target angle

// Damage
chip_damage = is_healing ? -1 : 1;
chip_increment = 0;
chip_threshold = is_healing ? 30 : 15;
turret_beam = 0;

// Deployment
placement_alpha = 0.5;
deploy_speed = 0.05;

// Effects
cfx_sentry_fire = hit_fx_create(player_id.turret_damage_effect, sentry_chip_threshold);;
cfx_heal = hit_fx_create(player_id.turret_heal_effect, sentry_chip_threshold);

// Health
health_max = is_weak_turret ? 16 : 64;     //maximum damage it can take
health = health_max;

// Invulnerability
damage_base_cd = 6;             //Minimum time that it takes for turrets to be able to take damage again
damage_cd = damage_base_cd;     //Time that it takes for turrets to be able to take damage again. Turrets spawn invulnerable.
damage_alpha = .33;             //The opacity when invulnerable.

// Movement
flying_dir = 0;
hsp_max = 6;


//State
state = -1;     // The state of the article.
                //  -1  =   Previewing
                //  0   =   Idle
                //  1   =   Active
                //  2   =   Destructing
state_timer = 0;

// Slowness Effect
sentry_slow_h = is_weak_turret ? 0.9 : 0.8;
sentry_slow_v = is_weak_turret ? 0.98 : 0.90;

sym_color0 = make_color_rgb(player_id.sym_r0,player_id.sym_g0,player_id.sym_b0);
