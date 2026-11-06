//other_init.gml    initiates for other players

/// Beam
// b_dist = 0;
// b_ang = 0;

// Teleporter
tp_tp_timer = 0;
tp_interval = 30;

if ("dash_speed" in self) {orig_dash_speed = dash_speed;}


// Turrets
is_damage_target = false;
turrets_damaging = [];
is_healing_target = false;
turrets_healing = [];


//Reset outline
outline_color = [0,0,0];

// #define toggle_damage_target(turret, toggle)
// if toggle {
//     turrets_damaging = add_turret(turrets_damaging, turret);
// }
// else {
//     turrets_damaging = remove_turret(turrets_damaging, turret);
// }

// if is_damage_target != toggle {
//     dash_speed = toggle ? 3 : original_dash_speed;
//     is_damage_target = toggle;
// }

// #define toggle_healing_target(turret, toggle)
// if toggle {
//     turrets_healing = add_turret(turrets_healing, turret);
// }
// else {
//     turrets_healing = remove_turret(turrets_healing, turret);
// }
// if is_healing_target != toggle {
//     is_healing_target = toggle;
// }

// #define add_turret(turret_array, turret)
// var index = array_find_index(turret_array, turret);
// if index == -1 {
//     array_push(turret_array, turret);
// }

// #define remove_turret(turret_array, turret)
// var index = 0;
// index = array_find_index(turret_array, turret);
// if index != -1 {
//     turret_array[index] = noone;    // Clear the turret.
// }

// var new_array = [];
// for (i=0; i < array_length(turret_array); i++)
// {
//     if turret_array[i] != noone {
//         array_push(new_array, turret_array[i]);     // Rebuild array with only turrets that exist.
//     }
// }
// turret_array = array_clone(new_array);
// return turret_array;
