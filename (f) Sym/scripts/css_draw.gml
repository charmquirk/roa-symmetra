// Lukaru's css draw, with Muno's base

var clear_top = 48;
var clear_bottom = 151; // Location of text
var rect_margin = 4;
var rect_width = 6*(min(image_alpha, 1));
var rect_height = 8;
var name_gap = 40;
var box_row = 2; //number of swatches per row of the black rectangle
var alpha_start = 20;

var temp_x = x + 14;
var temp_y = y - 4;

var total_colors = 6;

var all_colors = [];

// Gets each color for each palette slot
for (k = 0; k < total_colors; k++) {
	// var red1 = get_color_profile_slot_r(get_player_color( player ), k);
	// var green1 = get_color_profile_slot_g(get_player_color( player ), k);
	// var blue1 = get_color_profile_slot_b(get_player_color( player ), k);
	// all_colors[@k] = merge_colour(make_colour_rgb(red1, green1, blue1), c_white, 0);
	var red0 = get_color_profile_slot_r(get_player_color( player ), k);
	var green0 = get_color_profile_slot_g(get_player_color( player ), k);
	var blue0 = get_color_profile_slot_b(get_player_color( player ), k);
	all_colors[@k] = merge_colour(make_colour_rgb(red0, green0, blue0), c_white, 0);
}


//patch_ver = string(get_char_info(player, INFO_VER_MAJOR)) + "." + string(get_char_info(player, INFO_VER_MINOR));
patch_day = "17";
patch_month = "MAR";

var num_alts = 16;
var alt_new = get_player_color(player);
var alt_prev;


// Alpha decay - fade out
image_alpha = max(image_alpha-0.2, 0);


if (alt_new < 16) {
	// Alt is image index -1, so this function plays when that is not true
	if (alt_new != image_index -1) {image_alpha = alpha_start;}
}
else {
	if (alt_new == alt_prev) {image_alpha = alpha_start;}
}
// Sets image_index to the current alt
image_index = alt_new;
alt_prev = alt_new;
// alt_count = real(alt_new);


alt_name[0]  = "Symmetra";
alt_name[1]  = "Saffron";
alt_name[2]  = "Cayenne";
alt_name[3]  = "Turmeric";
alt_name[4]  = "Cardamom";
alt_name[5]  = "Gameboy";
alt_name[6]  = "Basil";
alt_name[7]  = "Sea";
alt_name[8]  = "Peacock";
alt_name[9]  = "Lavender";
alt_name[10]  = "Hyacinth";
alt_name[11]  = "Cinnamon";
alt_name[12]  = "Ash";
alt_name[13]  = "Charcoal";
alt_name[14]  = "Trauma";
alt_name[15]  = "Rework";

alt_name[18]  = "Utopaea";



draw_set_halign(fa_left);
// Draw patch number
// textDraw(temp_x + 164, temp_y + 42, "fName", colourrrrr, 0, 1000, 1, false, 0.3, "v" + patch_ver);
// Draw patch date
// textDraw(temp_x + 6, temp_y + 36, "fName", colourrrrr, 0, 1000, 1, true, 1, patch_day + " " + patch_month);
// if (image_alpha > 0)
// 	rectDraw(temp_x, temp_y + 141 - floor((image_alpha>1?1:image_alpha)*3.5)*2, temp_x + 201, temp_y + 142, c_black);


//var abyss_enbled = get_match_setting(SET_RUNE)

// Palatte
if (image_alpha > 0) {
	// Background black rectangle
rectDraw(temp_x - rect_margin, temp_y + clear_top  + (rect_margin + rect_height)*(total_colors/box_row), temp_x + (rect_width + rect_margin)*box_row*(min(image_alpha, 1)), temp_y + clear_top - rect_margin*2, c_black);
    if (image_alpha > 0.1) {
    	for (j = 0; j < total_colors; ++j) {
        	var draw_color = all_colors[j];
        	var current_row = floor(j/box_row);
        	var draw_y = (temp_y + clear_top + rect_margin*(current_row) + (rect_height)*current_row);
        	var draw_x = (temp_x + (rect_margin + rect_width)*(min(image_alpha, 1)) * (j - (box_row*current_row)));
        	rectDraw(draw_x, draw_y + rect_height, draw_x + rect_width*(min(image_alpha, 1)), draw_y, draw_color);
    	}
    }
}




draw_set_halign(fa_left);
 
//include alt. name
if (get_player_color(player) == 0){
	textDraw(temp_x, temp_y + clear_bottom - name_gap, "fName", c_white, 0, 1000, 1, true, image_alpha, alt_name[alt_new]);
	// textDraw(temp_x + 4 , temp_y + clear_bottom - name_gap, "fName", c_white, 0, 1000, 1, true, 1, string(array_get(alt_name)));
}
else{
	textDraw(temp_x, temp_y + clear_bottom - name_gap, "fName", all_colors[0], 0, 1000, 1, true, image_alpha, alt_name[alt_new]);
}

#define textDraw(x, y, font, color, lineb, linew, scale, outline, alpha, string)

draw_set_font(asset_get(argument[2]));

if (argument[7]) // outline. doesn't work
{
    for (i = -1; i < 2; i++)
	{
        for (j = -1; j < 2; j++)
		{
			if (argument[8] > 0)
				draw_text_ext_transformed_color(argument[0] + i * 2, argument[1] + j * 2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, c_black, c_black, c_black, c_black, argument[8]);
        }
    }
}

if (argument[8] > 0)
	draw_text_ext_transformed_color(argument[0], argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[3], argument[3], argument[3], argument[3], argument[8]);

return string_width_ext(argument[9], argument[4], argument[5]);

#define rectDraw(x1, y1, x2, y2, color)
 
draw_rectangle_color(argument[0], argument[1], argument[2], argument[3], argument[4], argument[4], argument[4], argument[4], false);
