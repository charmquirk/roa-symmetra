//draw_hud

uses_shader = true;

if !("sym_r0" in self) { exit; }
// Display Ammo capacity
var sym_color0 = make_color_rgb(sym_r0,sym_g0,sym_b0);  //get_color_profile_slot_r(player, 0);
var sym_color1 = make_color_rgb(sym_r1,sym_g1,sym_b1);
textDraw(temp_x+160, temp_y-20, "fName", sym_color0, 0, 1000, 1, true, 1, "Ammo " + string(floor(ammo/10)));

textDraw(temp_x+160, temp_y-20, "fName", c_white, 0, 1000, 1, false, 1/(max_ammo/ammo), "Ammo " + string(floor(ammo/10)));

// Barrier
if (barrier_timer > 0) {
    if has_rune("O") { draw_sprite_ext(sprite_get("ability_armor_cooldown"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);}
    else {draw_sprite_ext(sprite_get("ability_projectedbarrier_cooldown"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);}
    draw_debug_text(temp_x + 13, temp_y - 28, string(round(barrier_timer/60)));
}
else {
    if special_down && attack == AT_FSPECIAL && window == 2 { //active
        if has_rune("O") {draw_sprite_ext(sprite_get("ability_armor_active"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);}
        else {draw_sprite_ext(sprite_get("ability_projectedbarrier_active"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);}
    }
    else { //inactive
        if has_rune("O") {draw_sprite_ext(sprite_get("ability_armor"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);}
        else {draw_sprite_ext(sprite_get("ability_projectedbarrier"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);}
    }
}

// Turret
if (turret_charges <= 0 && !has_rune("E")) || (has_rune("E") && turret_timer > 0) { //Cooldown
    if !has_rune("I") && !has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    if !has_rune("I") && has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_healing_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    if has_rune("I") && !has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_flying_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    if has_rune("I") && has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_flying_healing_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
}
else {
    if (special_down && attack == AT_DSPECIAL && window == 2 && !has_rune("E")) || (has_rune("E") && instance_exists(sentry)) { //active
        if !has_rune("I") && !has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_active"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        if !has_rune("I") && has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_healing_active"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        if has_rune("I") && !has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_flying_active"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        if has_rune("I") && has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_flying_healing_active"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    }
    else { //inactive
        if !has_rune("I") && !has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        if !has_rune("I") && has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_healing"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        if has_rune("I") && !has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_flying"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        if has_rune("I") && has_rune("H") {draw_sprite_ext(sprite_get("ability_sentryturret_flying_healing"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    }
}
if turret_timer > 0 {
    draw_debug_text(temp_x + 53, temp_y - 28, string(round((turret_timer+ ((turret_charges - max_turrets + 1)*turret_rate))/60)));
    // textDraw(temp_x + 57, temp_y - 28, "fName", c_white, 0, 1000, 1, true, 1, string(round((turret_timer+ ((turret_charges - max_turrets + 1)*turret_rate))/60))); //subtracts missing turrets to show the cooldown for the next turret
}
if max_turrets > 1 {
    if turret_charges == 0 {
        draw_sprite_ext(sprite_get("charge_empty"), image_index, temp_x+44, temp_y-68, 1, 1, 0, c_white, 1);
    }
    else {
        draw_sprite_ext(sprite_get("charge"), image_index, temp_x+44, temp_y-68, 1, 1, 0, c_white, 1);
    }
    draw_debug_text(temp_x + 53, temp_y - 61, string(turret_charges));
    // textDraw(temp_x + 57, temp_y - 62, "fName", c_black, 0, 1000, 1, false, 1, string(turret_charges));
    
}





// Teleporter
if (attack == AT_USPECIAL && special_down) || instance_exists(teleporter_entrance) || instance_exists(teleporter_exit) {
    draw_sprite_ext(sprite_get("ability_oldteleporter_active"), image_index, temp_x+80, temp_y-40, 1, 1, 0, c_white, 1);
}
else {
    if (tp_timer > 0) {
        draw_sprite_ext(sprite_get("ability_oldteleporter_cooldown"), image_index, temp_x+80, temp_y-40, 1, 1, 0, c_white, 1);
        draw_debug_text(temp_x + 93, temp_y - 28, string(round(tp_timer/60)));
    }
    else {
        draw_sprite_ext(sprite_get("ability_oldteleporter"), image_index, temp_x+80, temp_y-40, 1, 1, 0, c_white, 1);
    }
}


if attack == AT_JAB && ammo > 0 {
    // draw_sprite_ext(sprite_get("beam_charges_bar"), -1, temp_x+30, temp_y+40, 1, (-10 + -(clamp(charge, charge, charge_3))/(charge_3/22)), 0, sym_color2, 1);        //(-clamp(charge, 0, charge_3))/(charge_3/32)
    draw_sprite_ext(sprite_get("beam_charges_bar"), -1, temp_x+30, temp_y+40, 1, (-10 + -(clamp(charge, 0, charge_2))/(charge_2/11) -(clamp(charge, 0, charge_3))/(charge_3/11)), 0, sym_color1, 1);        //(-clamp(charge, 0, charge_3))/(charge_3/32)
    
    if attack_down {
        draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y+30, 1, 1, 0, sym_color0, 1);
        if charge >= charge_2 {
            draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y+20, 1, 1, 0, sym_color0, 1);
        }
        if charge >= charge_3 {
            draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y+10, 1, 1, 0, sym_color0, 1);
        }
    }
}

//Ultimate Charge
// if has_rune("L") {textDraw(temp_x+170, temp_y-38, "fName", sym_color0, 0, 100, 1, true, 1, "Ultimate "+string(round(ult_charge/(ult_cost/100))) + "%");}
if has_rune("L") {
    if ult_charge < ult_cost {
        draw_sprite_ext(sprite_get("ultimate_teleporter_cooldown"), -1, temp_x+140, temp_y-70, 1, 1, 0, c_white, 1);
        draw_sprite_ext(sprite_get("ultimate_teleporter_charging"), -1, temp_x+140, temp_y-70, 1, 1, 0, sym_color1, ult_charge/ult_cost);
        if !instance_exists(teleporter_ultimate) {draw_debug_text(temp_x+154, temp_y-54,string(round(ult_charge/(ult_cost/100))) + "%");}
    }
    else {
        draw_sprite_ext(sprite_get("ultimate_teleporter_charging"), -1, temp_x+140, temp_y-70, 1, 1, 0, sym_color1, 1);
        if attack == AT_EXTRA_2 && window == 2 { ///&& attack == AT_DSPECIAL && window == 2
            draw_sprite_ext(sprite_get("ultimate_teleporter_active"), -1, temp_x+140, temp_y-70, 1, 1, 0, sym_color0, 1);
        }
        draw_sprite_ext(sprite_get("ultimate_teleporter"), -1, temp_x+140, temp_y-70, 1, 1, 0, c_white, 1);
    }
    
    
}


draw_sprite_ext(sprite_get("beam_charges_hud"), -1, temp_x+28, temp_y+8, 1, 1, 0, c_white, 1);
// draw_debug_text(temp_x, temp_y - 70,  string(tp_team));
// draw_debug_text(temp_x, temp_y - 86,  string(state));
// draw_debug_text(temp_x, temp_y - 104, "DEAD = " + string(PS_DEAD));
// draw_debug_text(temp_x, temp_y - 70,  string(turrets));
// if orb_h != undefined {draw_debug_text(temp_x, temp_y - 64,  string(darctan(orb_v/orb_h)) +" calc");} //calculated weapon aim based on orb values
// draw_debug_text(temp_x, temp_y - 80,  string(weapon_aim));
// draw_debug_text(temp_x, temp_y - 96,  "H" + string(orb_h));
// draw_debug_text(temp_x+48, temp_y - 96, "V" + string(orb_v));
// draw_debug_text(temp_x, temp_y - 96,  "X: " + string(weapon_x));
// draw_debug_text(temp_x, temp_y - 128,  "Y: " + string(weapon_y));
// draw_debug_text(temp_x, temp_y - 164,  string(beam_target));
// if instance_exists(teleporter_exit) {
//     draw_debug_text(temp_x, temp_y - 128,  "x =" + string(teleporter_exit.x));
//     // draw_debug_text(temp_x+96, temp_y - 128,  "tp_x =" + string(teleporter_exit.tp_x));
// }

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

