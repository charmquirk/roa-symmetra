//draw_hud

if !("sym_r0" in self) {
    exit;
}

var sym_color0 = make_color_rgb(sym_r0,sym_g0,sym_b0);
var sym_color1 = make_color_rgb(sym_r1,sym_g1,sym_b1);
var sym_color2 = make_color_rgb(sym_r2,sym_g2,sym_b2);

// Display Ammo capacity
textDraw(temp_x+116, temp_y-20, "fName", sym_color0, 0, 1000, 1, true, 1, "Ammo " + string(floor(ammo/10)));

textDraw(temp_x+116, temp_y-20, "fName", c_white, 0, 1000, 1, false, 1/(max_ammo/ammo), "Ammo " + string(floor(ammo/10)));

// construct
// Display cooldown time, ability icon, and charges if more than one is available
if (constructs_available > 0) { // if you can place one
    if (attack == AT_DSPECIAL && attack_down && window == 2) {
        if !has_rune("L") {draw_sprite_ext(sprite_get("ability_floor_active"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        else {draw_sprite_ext(sprite_get("ability_solid_active"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    }
    else {
        if !has_rune("L") {draw_sprite_ext(sprite_get("ability_floor"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        else {draw_sprite_ext(sprite_get("ability_solid"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    }
    if (max_constructs > 1) {
        draw_sprite_ext(sprite_get("charge_empty"), image_index, temp_x+44, temp_y-68, 1, 1, 0, c_white, 1);
    }
}
else { // on cooldown
    if instance_exists(construct) && max_constructs == 1 {
        if !has_rune("L") {draw_sprite_ext(sprite_get("ability_floor_active_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        else {draw_sprite_ext(sprite_get("ability_solid_active_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    }
    else {
        if !has_rune("L") {draw_sprite_ext(sprite_get("ability_floor_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
        else {draw_sprite_ext(sprite_get("ability_solid_cooldown"), image_index, temp_x+40, temp_y-40, 1, 1, 0, c_white, 1);}
    }
    if (max_constructs > 1) {
        draw_sprite_ext(sprite_get("charge"), image_index, temp_x+44, temp_y-68, 1, 1, 0, c_white, 1);
    }
}
if (construct_timer > 0) { draw_debug_text(temp_x + 53, temp_y - 28, string(round(construct_timer/60))); } // Display construct cooldown time
if (max_constructs > 1) { draw_debug_text(temp_x+53, temp_y - 61, string(constructs_available)); } // Display construct charges

// Teleporter
// Display cooldown time and ability icon
if (tp_timer > 0) {
    if instance_exists(teleporter_entrance) && instance_exists(teleporter_entrance) {
        draw_sprite_ext(sprite_get("ability_teleporter_active_cooldown"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);
    }
    else {
        draw_sprite_ext(sprite_get("ability_teleporter_cooldown"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);
    }
    
    draw_debug_text(temp_x + 13, temp_y - 28, string(round(tp_timer/60)));
    
}
else {
    if instance_exists(teleporter_entrance) && instance_exists(teleporter_entrance) {
        draw_sprite_ext(sprite_get("ability_teleporter_active"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);
    }
    else {
        draw_sprite_ext(sprite_get("ability_teleporter"), image_index, temp_x, temp_y-40, 1, 1, 0, c_white, 1);  
    }
}

if attack == AT_FSPECIAL && ammo > 0 {
    // draw_sprite_ext(sprite_get("beam_charges_bar"), -1, temp_x+30, temp_y+40, 1, (-10 + -(clamp(charge, charge, charge_3))/(charge_3/22)), 0, sym_color2, 1);        //(-clamp(charge, 0, charge_3))/(charge_3/32)
    draw_sprite_ext(sprite_get("beam_charges_bar"), -1, temp_x+30, temp_y+40, 1, (-12 + -(clamp(charge, 0, charge_2))/(charge_2/10) -(clamp(charge, 0, charge_3))/(charge_3/10)), 0, sym_color1, 1);        //(-clamp(charge, 0, charge_3))/(charge_3/32)
    
    if special_down {
        draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y+30, 1, 1, 0, sym_color0, 1);
        if charge >= charge_2 {
            draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y+20, 1, 1, 0, sym_color0, 1);
        }
        if charge >= charge_3 {
            draw_sprite_ext(sprite_get("beam_charges_full"), -1, temp_x+30, temp_y+10, 1, 1, 0, sym_color0, 1);
        }
    }
    
}

draw_sprite_ext(sprite_get("beam_charges_hud"), -1, temp_x+28, temp_y+8, 1, 1, 0, c_white, 1);

// draw_debug_text(temp_x+32, temp_y - 80, string(charge));
// draw_debug_text(temp_x+53, temp_y - 80, string(beam_chip));
// draw_debug_text(temp_x, temp_y - 80, string(sym_r));
// draw_debug_text(temp_x, temp_y - 100, string(sym_g));
// draw_debug_text(temp_x, temp_y - 120, string(sym_b));

// draw_debug_text(temp_x+40, temp_y - 120, string(teleporter_entrance.orig_player_id));
// draw_debug_text(temp_x+128, temp_y-154, "x = " + string(beam_x));
// draw_debug_text(temp_x+128, temp_y-128, "y = " + string(beam_y));
// draw_debug_text(temp_x+128, temp_y-48, "@" + string(beam_target));
// draw_debug_text(temp_x+128, temp_y-64, "BTime = " + string(beam_timer));
// draw_debug_text(temp_x+128, temp_y-96,  string(weapon_aim) + " o");
// draw_debug_text(temp_x+128, temp_y-64,  string(beam_length) + " px");
// draw_debug_text(temp_x+128, temp_y-32, string(constructs));
// draw_debug_text(temp_x+256, temp_y-32, string(id));

// draw_debug_text(temp_x, temp_y-58,  string(y));


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

