// articleplatform_init 
// Solid PLatform

//Sprite and direction
sprite_index = sprite_get("pb_plat");
mask_index = -1;
orig_player_id = player_id;
for_player = noone;
uses_shader = true;
state_timer = 0;
state = 0;
anim_speed = 0.2;