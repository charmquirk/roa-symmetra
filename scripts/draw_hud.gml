//draw_hud

uses_shader = true;



if !("sym_r0" in self) { exit; } // Skip if there are no player colors
var sym_color0 = make_color_rgb(sym_r0,sym_g0,sym_b0);  //get_color_profile_slot_r(player, 0);
var sym_color1 = make_color_rgb(sym_r1,sym_g1,sym_b1);  //get_color_profile_slot_r(player, 1);


// Display Ammo capacity
textDraw(temp_x+160, temp_y-20, "fName", sym_color0, 0, 1000, 1, true, 1, "Ammo " + string(floor(ammo/10)));
textDraw(temp_x+160, temp_y-20, "fName", c_white, 0, 1000, 1, false, 1/(max_ammo/ammo), "Ammo " + string(floor(ammo/10)));


// Barrier cooldown
var fspecial_sprite_name = "";
if (barrier_timer > 0) {
    fspecial_sprite_name = "ability_projectedbarrier_cooldown";
}
else {
    fspecial_sprite_name = (special_down && attack == AT_FSPECIAL && window == 2) ? "ability_projectedbarrier_active" : "ability_projectedbarrier"
}
draw_sprite_ext(sprite_get(fspecial_sprite_name), 0, temp_x, temp_y-40, 1, 1, 0, c_white, 1);
if (barrier_timer > 0) {    draw_debug_text(temp_x + 13, temp_y - 28, string(round(barrier_timer/60))); }


// Turret
var dspecial_hud_sprite = "";
if turret_timer > 0 { //Cooldown
    dspecial_hud_sprite = dspecial_hud_sprite_cooldown;
}
else {
    if (special_down && attack == AT_DSPECIAL && window == 2 && !has_rune_more_turrets) || (has_rune_more_turrets && instance_exists(turrets[0])) { //active
        dspecial_hud_sprite = dspecial_hud_sprite_active;
       }
    else { //inactive
        dspecial_hud_sprite = dspecial_hud_sprite_inactive;
        }
}
draw_sprite_ext(sprite_get(dspecial_hud_sprite), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);

// Turret cooldown
if turret_timer > 0 {
    var charges_needed = turret_charges_max - turret_charges;
    var ticks_left = turret_timer + (charges_needed * turret_rate);
    var time_left = round(ticks_left/60);
    draw_debug_text(temp_x + 53, temp_y - 28, string(time_left));
    // textDraw(temp_x + 57, temp_y - 28, "fName", c_white, 0, 1000, 1, true, 1, string(round((turret_timer+ ((turret_charges - max_turrets + 1)*turret_rate))/60))); //subtracts missing turrets to show the cooldown for the next turret
}

// Turret charges
if has_rune_more_turrets {
    var turret_charge_sprite_name = turret_charges == 0 ? "charge_empty" : "charge";
    draw_sprite_ext(sprite_get(turret_charge_sprite_name), 0, temp_x+44, temp_y-68, 1, 1, 0, c_white, 1);
    draw_debug_text(temp_x + 53, temp_y - 61, string(turret_charges));
}

// Teleporter
var uspecial_sprite_name = "ability_teleporter";
if attack == AT_USPECIAL && special_down {
    uspecial_sprite_name = "ability_teleporter_active";
}
else if tp_timer > 0 {
    uspecial_sprite_name = "ability_teleporter_cooldown";
}
draw_sprite_ext(sprite_get(uspecial_sprite_name), 0, temp_x+80, temp_y-40, 1, 1, 0, c_white, 1);
var time_left = round(tp_timer/60);
if tp_timer > 0 {   draw_debug_text(temp_x + 93, temp_y - 28, string(time_left));  }


// Beam charges
if attack == AT_JAB && ammo > 0 {
    // draw_sprite_ext(sprite_get("beam_charges_bar"), -1, temp_x+30, temp_y+40, 1, (-10 + -(clamp(charge, charge, charge_3))/(charge_3/22)), 0, sym_color2, 1);        //(-clamp(charge, 0, charge_3))/(charge_3/32)
    
    var bar_2_length = clamp(beam_charge, 0, beam_charge_2)/(beam_charge_2/11)
    var bar_3_length = clamp(beam_charge, 0, beam_charge_3)/(beam_charge_3/11)
    draw_sprite_ext(sprite_get("beam_charges_bar"), -1, temp_x+30, temp_y+40, 1, (-10 + -(bar_2_length) -(bar_3_length)), 0, sym_color1, 1);        //(-clamp(charge, 0, charge_3))/(charge_3/32)
    
    if attack_down {
        var beam_hud_height = 0;
        
        if beam_charge < beam_charge_2 {      // Level 1
            beam_hud_height = 30;
        }
        else if beam_charge < beam_charge_3 { // Level 2
            beam_hud_height = 20
        }
        else {                      // Level 3
            beam_hud_height = 10
        }
        
        draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y + beam_hud_height, 1, 1, 0, sym_color0, 1);
    }
}
draw_sprite_ext(sprite_get("beam_charges_hud"), -1, temp_x+28, temp_y+8, 1, 1, 0, c_white, 1);


//Ultimate Charge
if has_rune_spawn_point {
    // Charging colors
    var ult_background_color = c_black;
    var ult_foreground_color = c_white; 
    
    if ult_charge >= ult_cost {
        if attack == AT_EXTRA_2 && window == 2 { // Active color
            ult_foreground_color = c_white;
        }
        else { // Inactive Color
            ult_foreground_color = sym_color1;
        }
    }
    
    draw_sprite_ext(sprite_get(ult_sprite_background), -1, temp_x+140, temp_y-70, 1, 1, 0, ult_background_color, ult_charge/ult_cost);
    draw_sprite_ext(sprite_get(ult_sprite_foreground), -1, temp_x+140, temp_y-70, 1, 1, 0, ult_foreground_color, 1);
    if ult_charge < ult_cost && !instance_exists(teleporter_ultimate) {draw_debug_text(temp_x+154, temp_y-54,string(round(ult_charge/(ult_cost/100))) + "%");}
}

#define textDraw(x, y, font, color, lineb, linew, scale, outline, alpha, string)

draw_set_font(asset_get(argument[2]));

if argument[7]{ //text outline
    for (i = -1; i < 2; i++){
        for (j = -1; j < 2; j++){
            draw_text_ext_transformed_color(argument[0] + i * 2, argument[1] + j * 2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, c_black, c_black, c_black, c_black, 1);
        }
    }
}

draw_text_ext_transformed_color(argument[0], argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[3], argument[3], argument[3], argument[3], argument[8]);

return string_width_ext(argument[9], argument[4], argument[5]);
