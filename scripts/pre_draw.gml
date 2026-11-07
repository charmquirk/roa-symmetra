// pre-draw
uses_shader = true;
shader_start();
if !(state == PS_HITSTUN || state == PS_HITSTUN_LAND || state == PS_TUMBLE || state == PS_PRATFALL || state == PS_PRATLAND || state == PS_FROZEN || state == PS_WRAPPED || state == PS_DEAD) { //if able to attack
    
    // // Orb aiming guide
    // if attack == AT_NSPECIAL && special_down && ammo > 0  {
    //     var orb_angle = darctan2(orb_v, orb_h);
    //     draw_sprite_ext(sprite_get("orb_guide"), -1, weapon_x, weapon_y, 30/orb_speed, 1, orb_angle, c_white, 0.5);
    // }
    
    if attack == AT_JAB && attack_down && ammo > 0 {
        if !collision_point(beam_x, beam_y, self, false, false) { //If colliding with beam maker, don't draw the beam
            var beam_sprite = "";
            if beam_charge < beam_charge_2        { beam_sprite = "beam_w1";   }        // LEVEL 1
            else if beam_charge < beam_charge_3   { beam_sprite = "beam_w2";   }        // LEVEL 2
            else if beam_charge >= beam_charge_3  { beam_sprite = "beam_w4";   }        // LEVEL 3
        }
        draw_sprite_ext(sprite_get(beam_sprite), -1, weapon_x, weapon_y, abs(beam_length)/2, 1, weapon_aim, c_white, 1);
    }
    
    if ((state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) && attack == AT_JAB){
        if spr_dir == -1 {   draw_sprite_ext(sprite_get("jab_arm"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
        if spr_dir == 1 {   draw_sprite_ext(sprite_get("jab_arm_white"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
    }
}
shader_end();