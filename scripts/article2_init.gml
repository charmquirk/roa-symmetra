//article2_init

//
//  Teleporters
//


sprite_index = asset_get("empty_sprite");
mask_index = sprite_get("deployable_mask");
type = ""; // Previously used to differentiate entrance and exit. Now only differentiates ult vs normal.
can_be_grounded = true;
ignores_walls = false;
spr_dir = player_id.spr_dir;                        
uses_shader = true;      

// Deployment
placement_alpha = 0.5;      // The starting alpha value while state = -1
deploy_speed = 0.05;        // The amount of change in alpha per tick while state = -1

// Health
health_max = 60;
health = 0;
lifetime = player_id.tp_rate - 60*2;    //*2 lasts double the cooldown

// Invulnerability
damage_base_cd = 6;             //Minimum time that it takes for turrets to be able to take damage again
damage_cd = damage_base_cd;     //Time that it takes for turrets to be able to take damage again. Turrets spawn invulnerable.
damage_alpha = .33;

// Movement
accel = 0.9;
hsp_max = 24;
vsp_max = 24;
x_velocity = 0;
y_velocity = 0;
grav = 24;

// Stage
stage_x = get_stage_data(SD_X_POS);
stage_y = get_stage_data(SD_Y_POS);

//State
state = -1;     // The state of the article.
                //  -1  =   Previewing
                //  0   =   Idle
                //  1   =   Null
                //  2   =   Destroying
state_timer = 0;


sym_color0 = make_color_rgb(player_id.sym_r0,player_id.sym_g0,player_id.sym_b0);
