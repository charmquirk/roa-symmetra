//article1_init - runs once, when the article is created

//
//  Preview objects
//

//Sprite and direction
sprite_index = asset_get("empty_sprite");           
mask_index = -1;                                 
spr_dir = player_id.spr_dir;                        
uses_shader = true;                                 

//State
state = 0;                                          
state_timer = 0;

accel = 0.4;
max_hsp = 10;
max_vsp = 16;