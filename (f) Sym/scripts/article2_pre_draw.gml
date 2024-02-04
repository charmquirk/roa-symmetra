//article2_pre_draw        behind sprite

if ("damage_cd" in self) && ("tp_health" in self) {
if state == 0 && type != "ultimate" { draw_sprite_ext(sprite_get("teleporter_portal"), get_gameplay_time()/8, x,y, 1, 1, 0, c_white, (damage_cd > 0) ? damage_alpha : 1); }



if state == 0 && type == "ultimate" {
    // draw_sprite_ext(sprite_get("teleporter_hologram"), get_gameplay_time()/6, x,y, 1, 1, 0, c_white, (damage_cd > 0) ? 0 : 0.5);
    draw_sprite_ext(sprite_get("teleporter_hologram"), get_gameplay_time()/6, x,y, 1, 1, 0, c_white, (damage_cd > 0) ? 0 : 0.5);
    if player_id.tp_subject != noone {
        
        with player_id.tp_subject {draw_sprite_ext(sprite_index, get_gameplay_time()/8, other.x, other.y - 16 - char_height/2, spr_dir, 1, 0, other.sym_color0, (other.damage_cd > 0) ? 0 : 0.5);}//0.5*(other.player_id.tp_slide_step/other.player_id.tp_slide_length)
    }
    
    

// draw_debug_text(x,y,sprite_get_name(player_id.sprite_index))//get_gameplay_time()/image_number      (sprite_get_number(player_id.sprite_index) >= 1 ) ? 0 : sprite_get_number(player_id.sprite_index)
// draw_debug_text(x,y,string(player_id.tp_subject));

// var portal_player
// draw_sprite_ext(sprite_get("idle"),get_gameplay_time()/6,x,y-128,1,1,0,sym_color0,0.5);
// with oPlayer {
//     // if get_player_team(player) == get_player_team(other.player_id.player) {
//         shader_start();
//         draw_sprite_ext(sprite_get("idle"),get_gameplay_time()/6,x,y-128,1,1,0,other.sym_color0,0.5);
//         shader_end();
//     // }
// }

}
if state == 0 && damage_cd > 0 && tp_health < tp_max_health { //if damage taken
    draw_sprite_ext(sprite_get("healthbar"), 0,x-38,y-86, ((tp_max_health-tp_health)/tp_max_health)*78, 1, 0, sym_color0, 1); //78 is the width of the inner space
    draw_sprite(sprite_get("teleporter_healthbar"), 0, x,y-86);
}
}