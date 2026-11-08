//post-draw
uses_shader = true;

if ("sym_r0" in self) { var sym_color0 = make_color_rgb(sym_r0,sym_g0,sym_b0);  }  //get_color_profile_slot_r(player, 0);

shader_start();

if !(state == PS_AIR_DODGE
|| state == PS_ROLL_BACKWARD
|| state == PS_ROLL_BACKWARD
|| state == PS_HITSTUN
|| state == PS_HITSTUN_LAND
|| state == PS_TUMBLE
|| state == PS_PRATFALL
|| state == PS_PRATLAND
|| state == PS_FROZEN
|| state == PS_WRAPPED
|| state == PS_DEAD)
{
    // Draw arms for weapon based specials.
    if (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR)
    && (attack == AT_JAB || attack == AT_NSPECIAL)
    {
        var new_sprite = spr_dir == 1 ? "jab_arm" : "jab_arm_white";
        draw_sprite_ext(sprite_get(new_sprite), -1, x - spr_dir * arm_offset_x, y - arm_offset_y, 1, spr_dir, weapon_aim, c_white, 1);
    }
    
    // Draw beam tip.
    if (attack == AT_JAB && attack_down && window = 2 && beam_length != 0) {  draw_sprite(sprite_get("beam_tip"), -1, beam_x, beam_y); }
    
    // Draw text for ultimate.
    if attack == AT_EXTRA_2 && window == 2 {
        draw_debug_text(x-120, y-char_height-16, "SPECIAL = Place || ATTACK = Cancel")
        // textDraw(x, y,"fName", sym_color0, 0, 1000, 1, true, 1, "SPECIAL = Place || ATTACK = Cancel")
    }
}

shader_end();
