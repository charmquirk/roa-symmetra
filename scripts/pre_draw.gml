// pre-draw
uses_shader = true;

// var weapon_x = x + round(arm_offset_x*real(dcos(weapon_aim)));
// var weapon_y = y - 32 - round(arm_offset_x*real(dsin(weapon_aim)));
// var weapon_x = x + (beam_length/2)*real(dcos(weapon_aim));
// var weapon_y = y - 32 - (beam_length/2)*real(dsin(weapon_aim));



shader_start();


if attack == AT_FSPECIAL && special_down && ammo > 0 {
    // if beam_target == noone {
        if charge < charge_2 { draw_sprite_ext(sprite_get("beam_w1"), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, 1);      }        // LEVEL 1
        if charge >= charge_2 && charge < charge_3 { draw_sprite_ext(sprite_get("beam_w2"), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, 1);      }        // LEVEL 2
        if charge >= charge_3 { draw_sprite_ext(sprite_get("beam_w4"), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, 1);      }        // LEVEL 3
    // }
    // else {
    //     if charge < c_level2 { draw_sprite_ext(sprite_get("beam_w1"), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, beam_timer/beam_lock_time);     }       // LEVEL 1
    //     if charge > c_level2 { draw_sprite_ext(sprite_get("beam_w2"), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, beam_timer/beam_lock_time);     }       // LEVEL 2
    //     if charge > c_level3 { draw_sprite_ext(sprite_get("beam_w4"), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, beam_timer/beam_lock_time);     }       // LEVEL 3
    // }
}


if ((state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) && attack == AT_FSPECIAL){
    if spr_dir == -1 {   draw_sprite_ext(sprite_get("arm_weapon_beam"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
    if spr_dir == 1 {   draw_sprite_ext(sprite_get("arm_white"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
}




shader_end();