//article3_init

//
//  Sentry Turret
//

//Sprite and direction


image_alpha = 0;
uses_shader = true;
sentry_overlay = 0;

sentry_target = noone;
sentry_angle = 0;
if has_rune("E") { //maximum 1 turret
    sentry_range = 32*8;
    sentry_slow_h = 0.8;
    sentry_slow_v = 0.90;
    sentry_max_health = 64;     //maximum damage it can take
    sentry_damage = 2; //damage per chip threshold
}
else { //maximum 3 turrets
    sentry_range = 32*5;
    sentry_slow_h = 0.9;
    sentry_slow_v = 0.98;
    sentry_max_health = 16;     //maximum damage it can take
    sentry_damage = 1; //damage per chip threshold
}

turret_beam = 0;
sentry_chip = 0;        //Increments until hitting a damage threshold
// 30 ticks is a second
flying_speed = 2; //for Rune I

if has_rune("H") {  sentry_chip_threshold = 30;}  //healing turrets don't heal as quick as damage turrets damage.
else {  sentry_chip_threshold = 15;}

if has_rune("F") { //stop flying objects
    max_flying_speed = 6; //turrets move faster since it makes placing them quicker
}
else {
    if has_rune("H") { max_flying_speed = 6;} //healing turrets move slower
    else { max_flying_speed = 6; } //damage turrets move faster
}

flying_dir = 0;
placement_alpha = 0.5; //starting image alpha for placement mode, also for Rune I
if has_rune("I"){//Flying turrets
    deploy_speed = 0.1;
    //If it can fly but can't be placed
    if !has_rune("F") {lifetime = sentry_chip_threshold*5;}//8*60;  player_id.turret_rate*3/4
}
else {deploy_speed = 0.05;} //Stationary turrets



sentry_health = 0;         //damage taken
damage_base_cd = 6; //Minimum time that it takes for turrets to be able to take damage again
damage_cd = damage_base_cd;      //Time that it takes for turrets to be able to take damage again. Turrets spawn invulnerable.
damage_alpha = .33;

//State
state = -1;                                          
state_timer = 0;

can_be_grounded = true;
ignores_walls = false;

t_dist = 0;
t_ang = 0;

sym_color0 = make_color_rgb(player_id.sym_r0,player_id.sym_g0,player_id.sym_b0);

cfx_sentry_fire = hit_fx_create(player_id.turret_damage_effect, sentry_chip_threshold);;
cfx_heal = hit_fx_create(player_id.turret_heal_effect, sentry_chip_threshold);