// //Fancy CSS template by Muno
// //Put in css_draw.gml
 
// var temp_x = x + 8;
// var temp_y = y + 9;
 
// var num_alts = 21;
// var alt_cur = get_player_color(player);
 
 
// alt_name[0]  = "Symmetra";
// alt_name[1]  = "Saffron";
// alt_name[2]  = "Cayenne";
// alt_name[3]  = "Turmeric";
// alt_name[4]  = "Cardamom";
// alt_name[5]  = "Gameboy";
// alt_name[6]  = "Basil";
// alt_name[7]  = "Sea";
// alt_name[8]  = "Peacock";
// alt_name[9]  = "Lavender";
// alt_name[10]  = "Hyacinth";
// alt_name[11]  = "Utopaea";
// alt_name[12]  = "Cinnamon";
// alt_name[13]  = "Charcoal";
// alt_name[14]  = "Goddess";
// alt_name[15]  = "Vampire";
// alt_name[16]  = "Bubblegum";
// alt_name[17]  = "Lego";
// alt_name[18]  = "Greyscale";
// alt_name[19]  = "CYMK";
// alt_name[20]  = "Rework";


 
// rectDraw(temp_x, temp_y + 135, temp_x + 201, temp_y + 142, c_black);
 
// for(var i = 0; i < ceil(array_length(alt_name)/16); i++){
//     for(var j = 0; j < min(array_length(alt_name)-i*16, 16); j++){
//         var draw_color = (j+16*i == alt_cur); //? c_white : c_gray;
//         var draw_x = temp_x + 2 + 10 * j;
//         rectDraw(draw_x, temp_y + 137 - 5*i, draw_x + 7, temp_y + 140 - 5*i, draw_color);
//     }
// }
// //
 
// draw_set_halign(fa_left);
 
// //include alt. name
// textDraw(temp_x + 2, temp_y + 124 - 5*(ceil(array_length(alt_name)/16)-1), "fName", alt_cur, 0, 1000, 1, true, 1, "" + (alt_cur < 9 ? "0" : "") + string(alt_cur+1) + ": " + alt_name[alt_cur]);

 
// user_event(12);
// #define textDraw(x, y, font, color, lineb, linew, scale, outline, alpha, string)
 
// draw_set_font(asset_get(argument[2]));
 
// // if argument[7]{ //outline. doesn't work lol
// //     for (var i = -1; i < 2; i++){
// //         for (var j = -1; j < 2; j++){
// //             draw_text_ext_transformed_color(argument[0] + i * 2, argument[1] + j * 2, argument[9], argument[4], argument[5], argument[6], argument[6], 0, c_black, c_black, c_black, c_black, 1);
// //         }
// //     }
// // }
 
// draw_text_ext_transformed_color(argument[0], argument[1], argument[9], argument[4], argument[5], argument[6], argument[6], 0, argument[3], argument[3], argument[3], argument[3], argument[8]);
 
// return string_width_ext(argument[9], argument[4], argument[5]);
 
 
 
// #define rectDraw(x1, y1, x2, y2, color)
 
// draw_rectangle_color(argument[0], argument[1], argument[2], argument[3], argument[4], argument[4], argument[4], argument[4], false);
 
//  //deez nuts
 
//  //deez swouows





//-------------------------------------------------------------
/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ CSS Draw																	║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/
// // Number of alts
// num_alts = 21;
// // Array of alt names
// alt_names = [];
// // Put names into the array
// // for (i = 0; i < num_alts; i++) {
// //     array_push(alt_names, i);
// // }

// // Alt costume

// var alt_cur = get_player_color(player);


// rectDraw(x + 10, y + 10, 202, 6, c_black);

// var col = alt_ui_recolor == noone ? c_white : make_color_rgb(get_color_profile_slot_r(alt_cur, alt_ui_recolor), get_color_profile_slot_g(alt_cur, alt_ui_recolor), get_color_profile_slot_b(alt_cur, alt_ui_recolor));

// // var offset = (alt_cur > 15) * 16;

// // for (i = 0; i < (num_alts - offset) && i < 16; i++){
// // 	var draw_color = (i == alt_cur - offset) ? col : c_gray * 0.5;
// // 	var draw_x = x + 78 + 8 * i;
// // 	rectDraw(draw_x, y + 10, 6, 4, draw_color);
// // }

// var thin = num_alts > 21;

// for (i = 0; i < num_alts; i++){
// 	var draw_color = (i == alt_cur) ? col : c_gray * 0.5;
// 	var draw_x = x + 78 + (thin ? 4 : 8) * i;
// 	rectDraw(draw_x, y + 10, thin ? 2 : 6, 4, draw_color);
// }

// var txt = "#" + string(alt_cur);

// rectDraw(x + 76, y + 15, 42, 21, c_black);

// textDraw(x + 82, y + 19, "fName", col, 20, 1000, fa_left, 1, false, 1, txt, false);

// if use_alt_names{
// 	if alt_cur < array_length(alt_names) && alt_names[alt_cur] != ""{
// 		rectDraw(x + 10, y + 142 - is_online * 12, string_width_ext(alt_names[alt_cur], 1000, 200), 10, c_black);
// 		textDraw(x + 10, y + 141 - is_online * 12, "fName", col, 1000, 200, fa_left, 1, true, 1, alt_names[alt_cur], false);
// 	}
// }
// Lukaru's css draw, with Muno's base
// note: c_white is affected by Cupcake's colours


var clear_bottom = 148;
var rect_margin = 3;
var rect_width = 5;
var rect_height = 6;
var name_gap = 16;
var box_row = 21;

var temp_x = x + 8;
var temp_y = y - 4;



var red1 = get_color_profile_slot_r(get_player_color( player ), 0);
var green1 = get_color_profile_slot_g(get_player_color( player ), 0);
var blue1 = get_color_profile_slot_b(get_player_color( player ), 0);
var colourrrrr = merge_colour(make_colour_rgb(red1, green1, blue1), c_white, 0.5);

//patch_ver = string(get_char_info(player, INFO_VER_MAJOR)) + "." + string(get_char_info(player, INFO_VER_MINOR));
patch_day = "17";
patch_month = "MAR";

// Causes elements to fade out
image_alpha = max(image_alpha-0.015, 0);

var num_alts = 21;
var alt_new = get_player_color(player);
if ((alt_new != 28 && alt_new != image_index - 1) || (alt_new == 28 && (image_index == 15 || image_index == 1))) // image_index is global
// Starting alpha
image_alpha = 2;
image_index = alt_new;

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
alt_name[11]  = "Utopaea";
alt_name[12]  = "Cinnamon";
alt_name[13]  = "Charcoal";
alt_name[14]  = "Goddess";
alt_name[15]  = "Vampire";
alt_name[16]  = "Bubblegum";
alt_name[17]  = "Lego";
alt_name[18]  = "Greyscale";
alt_name[19]  = "CYMK";
alt_name[20]  = "Rework";


draw_set_halign(fa_left);
// Draw patch number
// textDraw(temp_x + 164, temp_y + 42, "fName", colourrrrr, 0, 1000, 1, false, 0.3, "v" + patch_ver);
// Draw patch date
// textDraw(temp_x + 6, temp_y + 36, "fName", colourrrrr, 0, 1000, 1, true, 1, patch_day + " " + patch_month);
// if (image_alpha > 0)
// 	rectDraw(temp_x, temp_y + 141 - floor((image_alpha>1?1:image_alpha)*3.5)*2, temp_x + 201, temp_y + 142, c_black);

if (image_alpha > 0.2) {
    for (j = 0; j < box_row; ++j) {
        //var draw_color = (j == image_index) ? colourrrrr : c_gray;
        //if j = box_row {
        	var draw_color = colourrrrr;
        //}
        var draw_y = temp_y + clear_bottom;
        var draw_x = (temp_x + rect_margin + (rect_margin + rect_width)* j);
        rectDraw(draw_x, draw_y + rect_height*(min(image_alpha, 1)), draw_x + rect_width, draw_y, draw_color);
    }
}


draw_set_halign(fa_left);
 
 
 
//include alt. name
if (get_player_color(player) == 0){
	textDraw(temp_x + 4, temp_y + clear_bottom - name_gap, "fName", c_white, 0, 1000, 1, true, image_alpha, alt_name[image_index]);
}
else{
    textDraw(temp_x + 4, temp_y + clear_bottom - name_gap, "fName", colourrrrr, 0, 1000, 1, true, image_alpha, alt_name[image_index]);
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
