//article2_init

//
//  Teleporters
//


sprite_index = asset_get("empty_sprite");
mask_index = sprite_get("teleporter_pad_mask");
can_be_grounded = true;
ignores_walls= false;
spr_dir = player_id.spr_dir;                        
uses_shader = true;                                 

//State
state = -1;
state_timer = 0;

accel = 0.9;
max_hsp = 24;
max_vsp = 24;
grav = 24;

// Stage
stage_x = get_stage_data(SD_X_POS);
stage_y = get_stage_data(SD_Y_POS);

lifetime = player_id.tp_rate-120;    //*2 lasts double the cooldown

spr_dir = player_id.spr_dir;

tp_xv = 0;
tp_yv = 0;

//Health & Damage
tp_max_health = 60; //maximum damage it can take
tp_health = 0;         //damage taken
damage_base_cd = 6; //Minimum time that it takes for turrets to be able to take damage again
damage_cd = damage_base_cd;      //Time that it takes for turrets to be able to take damage again. Turrets spawn invulnerable.
damage_alpha = .33;

sym_color0 = make_color_rgb(player_id.sym_r0,player_id.sym_g0,player_id.sym_b0);