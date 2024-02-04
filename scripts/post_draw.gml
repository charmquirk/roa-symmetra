//post-draw
uses_shader = true;

shader_start();



if ((state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) && attack == AT_JAB){
    // draw_sprite_ext(sprite_get("jab_aiming"), -1, x - (7*spr_dir), y-30, 1, spr_dir, weapon_aim, c_white, 1);
    // draw_sprite_ext(sprite_get("jab_aiming"), -1, x, y-32, 1, spr_dir, weapon_aim, c_white, 1);
    // draw_sprite_ext(sprite_get("jab_aiming"), -1, x, y-32, 1, spr_dir, weapon_aim, c_white, 1);
}
if (attack == AT_FSPECIAL && window == 2) {
    draw_sprite(sprite_get("beam_tip"), -1, beam_x, beam_y);
}

if attack == AT_DSPECIAL && window == 2 && constructs_available > 0 {
    if !has_rune("L") {
        draw_sprite_ext(sprite_get("platform"), 1, x, y, 1, 1, 0, c_white, 0.5);
        if construct_direction == -1 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+8, 1, 1, 180, c_white, 0.5); }
        if construct_direction == 0 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+8, 1, 1, 270, c_white, 0.5); }
        if construct_direction == 1 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+8, 1, 1, 0, c_white, 0.5); }
        if construct_direction == 2 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+8, 1, 1, 90, c_white, 0.5); }
    }
    else {
        draw_sprite_ext(sprite_get("solid"), 1, x, y+48, 1, 1, 0, c_white, 0.5);
        if construct_direction == -1 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+48, 1, 1, 180, c_white, 0.5); }
        if construct_direction == 0 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+48, 1, 1, 270, c_white, 0.5); }
        if construct_direction == 1 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+48, 1, 1, 0, c_white, 0.5); }
        if construct_direction == 2 { draw_sprite_ext(sprite_get("arrow_guide"), 1, x, y+48, 1, 1, 90, c_white, 0.5); }
    }
}
// if state == PS_AIR_DODGE {
//     // outline_color = [sym_b,sym_g,sym_r];
//     outline_color = [sym_r,sym_g,sym_b];
// }
// else {
//     outline_color = [0,0,0];
// }



if ((state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) && attack == AT_FSPECIAL){
    if spr_dir == 1 {   draw_sprite_ext(sprite_get("arm_weapon_beam"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
    if spr_dir == -1 {   draw_sprite_ext(sprite_get("arm_white"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
}
  	
if (attack == AT_FSPECIAL && window = 2 && beam_length != 0) {  draw_sprite(sprite_get("beam_tip"), -1, beam_x, beam_y); }


shader_end();