// called when the character gets KO'd

tp_timer = 0;
barrier_timer = 0;

move_cooldown[AT_FSPECIAL] = barrier_timer;
// move_cooldown[AT_USPECIAL] = tp_timer;

// instance_destroy(teleporter_entrance);
// instance_destroy(teleporter_exit);
sound_stop(sound_get("orb charging 1"));