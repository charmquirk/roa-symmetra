//article3_init - runs once, when the article is created

//
//  Platform Buddy
//

//Sprite and direction
sprite_index = sprite_get("pb_inactive");           
mask_index = -1;                                 
uses_shader = true;

for_player = noone;

//State
state = 0;                                          
state_timer = 0;
// enum state_lib {
//     idle,
//     active
// }

can_be_grounded = false;
ignores_walls = true;


// // Stage
// stage_x = get_stage_data(SD_X_POS);
// stage_y = get_stage_data(SD_Y_POS);

// // teleporter_exit = noone;
// // teleporter_entrance = noone;


