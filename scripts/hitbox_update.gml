//hitbox_update
// if orig_player_id.barrier == id && attack(AT_FSPECIAL){
//     if length >= get_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME)/2 { //900
        // clamp(pHitBox.image_alpha - 0.02, 0, 1)
//     }
// }
// if id = barrier {image_alpha = 0;}
if attack == AT_FSPECIAL {
    // health = 50;
    if has_rune("O") { // If circular
        if !has_rune("F") {// If you can't hold and release
            x = player_id.x;
            y = player_id.y - player_id.char_height/2;
        }
        with oPlayer {
            if instance_place(x, y, other) && (get_player_team(player) == get_player_team(other.player_id.player)|| get_match_setting(SET_TEAMATTACK) == true) {
                super_armor = true;
            }
        }
    }
}
