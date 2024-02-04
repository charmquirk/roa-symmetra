//post-draw
uses_shader = true;

if ("sym_r0" in self) {var sym_color0 = make_color_rgb(sym_r0,sym_g0,sym_b0);}  //get_color_profile_slot_r(player, 0);

shader_start();




if !(state == PS_AIR_DODGE || state == PS_ROLL_BACKWARD || state == PS_ROLL_BACKWARD|| state == PS_HITSTUN || state == PS_HITSTUN_LAND || state == PS_TUMBLE || state == PS_PRATFALL || state == PS_PRATLAND || state == PS_FROZEN || state == PS_WRAPPED || state == PS_DEAD) { //if able to attack


if ((state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) && (attack == AT_JAB || attack == AT_NSPECIAL)){
    if spr_dir == 1 {   draw_sprite_ext(sprite_get("jab_arm"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
    if spr_dir == -1 {   draw_sprite_ext(sprite_get("jab_arm_white"), -1, x - spr_dir*arm_offset_x, y-arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);  }
}

if (attack == AT_JAB && attack_down && window = 2 && beam_length != 0) {  draw_sprite(sprite_get("beam_tip"), -1, beam_x, beam_y); }


if attack == AT_EXTRA_2 && window == 2 {
    draw_debug_text(x-120,y-char_height-16,"SPECIAL = Place || ATTACK = Cancel")
    // textDraw(x, y,"fName", sym_color0, 0, 1000, 1, true, 1, "SPECIAL = Place || ATTACK = Cancel")
}


// Turret effects for self
// if ("turrets" in self) && ("turret_heal_effect" in self) && ("turret_damage_effect" in self) && has_rune("H") { //if the player has variables
//     with turrets { //Scan turrets
//         var turret_effect = player_id.turret_heal_effect;
//         var turret_effect_frames = 9;
//         if sentry_target != noone { //If turret has a target
//             if sentry_target == other.id { //If target is this player
//                 with(player_id)shader_start();
//                     draw_sprite_ext(turret_effect, floor(turret_effect_frames/(sentry_chip_threshold/get_gameplay_time())) , sentry_target.x, sentry_target.y-(sentry_target.char_height/2), 1, 1, 0, c_white, 1);
//                 with(player_id)shader_end();
//             }
//         }
//     }
// }

}
shader_end();

