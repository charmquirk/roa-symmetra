// called when the character gets KO'd

constructs_available = max_constructs;
construct_timer = 0;
tp_timer = 0;
barrier_timer = 0;

move_cooldown[AT_DSPECIAL] = 0;
move_cooldown[AT_FSPECIAL] = 0;
move_cooldown[AT_USPECIAL] = 0;

instance_destroy(teleporter_entrance);
instance_destroy(teleporter_exit);
instance_destroy(construct);
sound_stop(sound_get("orb charging 1"));