//other_post_draw

// Turret fire effect for other players
if "other_player_id" in self {
if ("turrets" in other_player_id) && ("turret_heal_effect" in other_player_id) && ("turret_damage_effect" in other_player_id) { //if the player has variables

    with other_player_id.sentry { //Scan turrets
        if has_rune("H") {
            var turret_effect = player_id.turret_heal_effect;
        }
        else {
            var turret_effect = player_id.turret_damage_effect;
        }
        var turret_effect_frames = 9;
        if sentry_target != noone { //If turret has a target
           
            if sentry_target == other.id { //If target is this player
                with(player_id)shader_start();
                    draw_sprite_ext(turret_effect, floor(turret_effect_frames/(sentry_chip_threshold/get_gameplay_time())) , sentry_target.x, sentry_target.y-(sentry_target.char_height/2), 1, 1, 0, c_white, 1);
                    //plays a frame cycle per damage/healing cycle//
                with(player_id)shader_end();
            }
        }
    }
}
}