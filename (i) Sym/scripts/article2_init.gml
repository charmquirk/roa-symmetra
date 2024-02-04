//article2_init

//
//  Teleporters
//

sprite_index = asset_get("teleportal_preview");
mask_index = sprite_get("teleportal");

spr_dir = player_id.spr_dir;  
can_be_grounded = true;
ignores_walls = false;
uses_shader = true;   
//anim_speed = 0.05;
anim_close = 240; //Time it takes to close portal
downtime = 60; //Time the portal cant be used before cooldown starts
min_alpha = 0.2 //minimum transparency of portal

//State
state = -1;
state_timer = 0;

accel = 0.9;
max_hsp = 24;
max_vsp = 24;

// Stage
stage_x = get_stage_data(SD_X_POS);
stage_y = get_stage_data(SD_Y_POS);

lifetime = player_id.tp_rate-downtime;
destroyed = false;
solid_direction = 0;