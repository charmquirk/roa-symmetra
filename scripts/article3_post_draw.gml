//article3_post_draw        in front of sprite

if !("state" in self) { exit;}

var sentry_head_sprite = "";
var sentry_head_opacity = 1;

switch state {
    case -1:
    case 2:
        break;
    case 0:
        sentry_head_sprite = "sentry_inactive"
        sentry_head_opacity = (state_timer-(0.5/deploy_speed))*(deploy_speed*2);
        break;
    case 1:
        sentry_head_sprite = "sentry_active"
        sentry_head_opacity = (damage_cd > 0) ? damage_alpha : 1;
        draw_sprite_ext(sprite_get("beam_w1"), -1, x, y, t_dist/2, 1, t_ang, c_white, sentry_head_opacity);         // Draw turret beam
}
draw_sprite_ext(sprite_get(sentry_head_sprite), -1, x, y, 1, 1, 0, c_white, sentry_head_opacity); // Draw turret head

draw_debug_text(x, y, "State: " + string(state));
draw_debug_text(x-15, y-32, "Timer: " + string(state_timer));
draw_debug_text(x-15, y-32, string(chip_damage));
