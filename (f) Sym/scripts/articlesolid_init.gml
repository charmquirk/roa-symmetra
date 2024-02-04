// articlesolid_init 
// Solid PLatform

//Sprite and direction
sprite_index = asset_get("empty_sprite");
orig_player_id = player_id;
uses_shader = true;

state = 0;
state_timer = 0;

anim_speed = 0.02;

lifetime_v = 120;
lifetime_h = 600;