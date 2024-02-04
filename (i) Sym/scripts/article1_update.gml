//
// Preview Objects
//



// Re-initiates based on type
switch(type) {
     case "solid_preview" :
        sprite_index = sprite_get("solid_preview");
        mask_index = sprite_get("solid_preview");
        break;
}

if (type == "solid_preview") {
    // Follow player
    x = player_id.x - 64*player_id.spr_dir;
    y = player_id.y - 96*(player_id.up_down);
}

spr_dir = player_id.spr_dir;