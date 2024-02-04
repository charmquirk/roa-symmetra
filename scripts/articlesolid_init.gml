// // articlesolid_init 
// // Solid Platform

sprite_index = sprite_get("solid");
mask_index = -1;
image_alpha = 0.5;
orig_player_id = player_id;
uses_shader = true;

state = -1;
state_timer = 0;

anim_speed = 0.05;
growth_speed = 0.05;

image_xscale = growth_speed;
image_yscale = image_xscale;

// lifetime_v = 120;
// lifetime_h = 600;
// lifetime_s = player_id.solid_rate*2;
follow_time = 120
lifetime = player_id.construct_rate*2; // used for follower solid only

ignores_walls = false;  //disables in floor placement but prevents people from
construct_speed = player_id.construct_speed;
construct_direction = player_id.construct_direction;