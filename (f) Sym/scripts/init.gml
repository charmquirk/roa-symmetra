// init is a script that creates variables when the player is created on the stage.
/*
 * Base Cast Frame Data:
 * docs.google.com/spreadsheets/d/19UtK7xG2c-ehxdlhCFKMpM4_IHSG-EXFgXLJaunE79I
 */






// STAT NAME		ZETTER VALUE   BASECAST RANGE   NOTES

// Physical size
char_height         = 64;       //                  not zetterburn's. this is just cosmetic anyway
knockback_adj       = 1;		// 0.9  -  1.2

// Ground movement
walk_speed          = 4;		// 3    -  4.5
walk_accel          = 0.4;		// 0.2  -  0.5
walk_turn_time      = 3;	    // 6
initial_dash_time   = 14;		// 8    -  16
initial_dash_speed  = 8;		// 4    -  9
dash_speed          = 7;		// 5    -  9
dash_turn_time      = 10;		// 8    -  20
dash_turn_accel     = 1.5;		// 0.1  -  2
dash_stop_time      = 4;		// 4    -  6
dash_stop_percent   = 0.35;		// 0.25 -  0.5
ground_friction     = 0.6;		// 0.3  -  1
moonwalk_accel      = 1.3;		// 1.2  -  1.4
    
// Air movement
leave_ground_max    = 6;		// 4    -  8
max_jump_hsp        = 6;		// 4    -  8
air_max_speed       = 4;  		// 3    -  7
jump_change         = 3;		// 3
air_accel           = 0.3;		// 0.2  -  0.4
prat_fall_accel     = 0.85;		// 0.25 -  1.5
air_friction        = 0.03;		// 0.02 -  0.07
max_fall            = 9;		// 6    -  11
fast_fall           = 14;		// 11   -  16
gravity_speed       = 0.4;		// 0.3  -  0.6
hitstun_grav        = 0.5;		// 0.45 -  0.53

// Jumps
jump_start_time     = 5;		// 5                this stat is automatically decreased by 1 after init.gml (dan moment), so its "real value" is 4. if you change this during a match, 4 is the value you should reset it to
jump_speed          = 9.5;		// 7.6  -  12       okay, zetter's is actually 10.99 but... come on
short_hop_speed     = 5;		// 4    -  7.4
djump_speed         = 10;		// 6    -  12       absa's is -1 because of her floaty djump
djump_accel         = 0;        // -1.4 -  0        absa's is -1.4, all other chars are 0. only works if the   djump_accel_end_time   variable is also set. floaty djumps should be adjusted by feel based on your char's gravity
djump_accel_end_time= 0;        //                  the amount of time that   djump_accel   is applied for
max_djumps          = 1;		// 0    -  3        the 0 is elliana because she has hover instead
walljump_hsp        = 7;		// 4    -  7
walljump_vsp        = 8;		// 7    -  10
land_time           = 4;		// 4    -  6
prat_land_time      = 10;		// 3    -  24       zetterburn's is 3, but that's ONLY because his uspecial is so slow. safer up b (or other move) = longer pratland time to compensate

// Shield-button actions
wave_friction       = 0.12;		// 0    -  0.15
roll_forward_max    = 9;        // 9    -  11
roll_backward_max   = 9;        // 9    -  11       always the same as forward
wave_land_time      = 8;		// 6    -  12
wave_land_adj       = 1.3;		// 1.2  -  1.5      idk what zetterburn's is
if has_rune("A") {
air_dodge_speed     = 16; 
}
else {
air_dodge_speed     = 8;        // 7.5   - 8
}
techroll_speed      = 10;       // 8    -  11



// Animation Info

// Misc. animation speeds
idle_anim_speed     = 0.1;
crouch_anim_speed   = 0.1;
walk_anim_speed     = 0.125;
dash_anim_speed     = 0.2;
pratfall_anim_speed = 0.25;

// Jumps
double_jump_time    = 32;		// 24   -  40
walljump_time       = 32;		// 18   -  32
wall_frames         = 2;		// may or may not actually work... dan pls

// Parry
dodge_startup_frames    = 1;
dodge_active_frames     = 1;
dodge_recovery_frames   = 4;

// Tech
tech_active_frames      = 3;
tech_recovery_frames    = 1;

// Tech roll
techroll_startup_frames     = 1;
techroll_active_frames      = 4;
techroll_recovery_frames    = 2;

// Airdodge
air_dodge_startup_frames    = 1;
air_dodge_active_frames     = 5;
air_dodge_recovery_frames   = 1;



// Roll
roll_forward_startup_frames     = 1;
roll_forward_active_frames      = 4;
roll_forward_recovery_frames    = 2;
roll_back_startup_frames        = 1;
roll_back_active_frames         = 4;
roll_back_recovery_frames       = 2;

// Crouch
crouch_startup_frames   = 2;
crouch_active_frames    = 8;
crouch_recovery_frames  = 2;

/*

Muno's Words of Wisdom: Due to a Certified Dan Moment, you must duplicate the
last frame of your crouch animation. So like, if your animation has 10 frames
total, add an 11th that's the copy of the 10th. You do NOT include this 11th
frame in the crouch_recovery_frames or etc; configure these values AS IF there
were only 10 frames.

The reason for this is that otherwise, the crouch just glitches out at the end
of the standing-up animation. Dan Moment

*/



// Hurtbox sprites
hurtbox_spr         = sprite_get("hurtbox");
crouchbox_spr       = asset_get("ex_guy_crouch_box");
air_hurtbox_spr     = -1; // -1 = use hurtbox_spr
hitstun_hurtbox_spr = -1; // -1 = use hurtbox_spr

// Victory
set_victory_bg(sprite_get("victory_background")); // victory_background.png
set_victory_theme(sound_get("victory_theme")); // victory_theme.ogg

// Movement SFX
land_sound          = asset_get("sfx_land_light");
landing_lag_sound   = asset_get("sfx_land_med");
waveland_sound      = asset_get("sfx_waveland_ran"); // recommended to try out all 14 base cast wavedash sfx (see sfx page in roa manual)
jump_sound          = asset_get("sfx_jumpground");
djump_sound         = asset_get("sfx_jumpair");
air_dodge_sound     = asset_get("sfx_quick_dodge");

// Visual offsets for when you're in Ranno's bubble
bubble_x = 0;
bubble_y = 8;





//
//  Ability init
//


// Ultimate
ult_charge = 3600;
ult_cost = 3600; // 2 minutes //Cost accounts for passive ultimate charge. 60 frames * 60 seconds * "X" minutes = time it takes to generate ultimate passively


// Barrier
barrier_timer = 0;
barrier_rate = 240; //default
if has_rune("O") && !has_rune("F") {  barrier_rate = 360; } //circular barrier but not placable
if !has_rune("O") && has_rune("F") {  barrier_rate = 240; } //not circular barrier but placable
if has_rune("O") && has_rune("F") {  barrier_rate = 480; } //circular barrier and placable


barrier_placing = false;

// Weapon
max_ammo = 600;
ammo = max_ammo;
weapon_aim = 0;
aim_accel = 0.25;    // The higher it is, the faster the acceleration
aim_decel = 0.5;    // The higher it is, the smoother the deceleration
aim_speed = 1;
angle_allowance = 2;
max_aim_speed = 10;

// Beam
beam_target = noone;
beam_list = [];     //List of eligble targets for beam
beam_chip = 0;        //Increments until hitting a damage threshold
beam_length = 0;
beam_timer = 0;
beam_x = 0;
beam_x_max = 0;
beam_y = 0;
beam_y_max = 0;
weapon_x = 0;
weapon_y = 0;
arm_offset_x = 8;
arm_offset_y = 33;
beam_offset = 40;//24
o_dist = 0;
o_angle = 0;    
charge = 0;     //current beam charge

if has_rune("G") { // Stick beam
beam_range = 32*12;
beam_preview_range = beam_range;
beam_max_range = beam_range + 96;
beam_lock_time = 60;
charge_decay = 1;
charge_2 = 30;                      // Charge cost for level 2 / how many frames until charge 2
charge_3 = charge_2 + 60;           // Charge cost for level 3 / how many frames until charge 3
charge_max = charge_3 + 15;        // Maximum charge points held
beam_chip_1 = 10;      // How many ticks does it take to deal damage
beam_chip_2 = 6;      // How many ticks does it take to deal damage
beam_chip_3 = 1;      // How many ticks does it take to deal damage
}
if !has_rune("G") { // Lock on
beam_range = 32*4;
beam_preview_range = beam_range;
beam_max_range = beam_range+32;
beam_lock_time = 60;
charge_decay = 1;
charge_2 = 60;                      // Charge cost for level 2 / how many frames until charge 2
charge_3 = charge_2 + 120;           // Charge cost for level 3 / how many frames until charge 3
charge_max = charge_3 + 30;        // Maximum charge points held
beam_chip_1 = 10;      // How many ticks does it take to deal damage
beam_chip_2 = 6;      // How many ticks does it take to deal damage
beam_chip_3 = 1;      // How many ticks does it take to deal damage
}
beam_chip_threshold = beam_chip_1;


// Orbs
orb_cost = 100;
miniorb_cost = 25;
orb_speed = 6;
orb_h = 0;
orb_v = 0;

// Sentry Turrets
sentry = noone;
turrets = [];
turret_timer = 0;
if has_rune("I") && !has_rune("F") {turret_rate = 60*5;} // shorter cooldown for aerial turrets that can't be placed
else {turret_rate = 60*8;}
turret_placing = false; //if has_rune("F") {}

if has_rune ("E") { max_turrets = 1; turret_charges = max_turrets;}
else {max_turrets = 3; turret_charges = max_turrets;}

orig_dash_speed = dash_speed;

// Teleporter
teleporters = [];
teleporter_entrance = noone;
teleporter_exit = noone;
teleporter_ultimate = noone;
tp_x = x;
tp_xv = 0;
tp_y = y;
tp_yv = 0;
tp_timer = 0;
tp_rate = 480;
tp_tp_timer = 0;
tp_interval = 30;
tp_team = []; // Array of dead teammates who can respawn
tp_subject = noone;
tp_slide_step = 0;
tp_slide = 0;
tp_slide_length = 120;


// Effects
cfx_beam_fire = hit_fx_create(sprite_get("cfx_beam_fire"), 8);
turret_heal_effect = sprite_get("cfx_heal");
turret_damage_effect = sprite_get("cfx_sentry_fire");

// Teleport Color
sym_r1 = get_color_profile_slot_r(get_player_color(player),1);
sym_g1 = get_color_profile_slot_g(get_player_color(player),1);
sym_b1 = get_color_profile_slot_b(get_player_color(player),1);

// Ammo empty color
sym_r0 = get_color_profile_slot_r(get_player_color(player),0);
sym_g0 = get_color_profile_slot_g(get_player_color(player),0);
sym_b0 = get_color_profile_slot_b(get_player_color(player),0);


// Kirby Support
kirbyability = 16;
newicon = 0;
swallowed = 0;
enemykirby = noone;



// Muno template: (don't change)

//user_event(14); // General init