// articleplatform_init


sprite_index = asset_get("empty_sprite");
mask_index = -1;

uses_shader = true;
state_timer = 0;
state = 0;
anim_speed = 0.05;

orig_player_id = player_id;
for_player = noone;

lifetime = 0;
construct_direction = player_id.construct_direction;