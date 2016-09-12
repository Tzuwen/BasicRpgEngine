///scr_move_state
scr_get_input();

if (dash_key) {
    var xdir = lengthdir_x(8, face*90);
    var ydir = lengthdir_y(8, face*90);
    var speaker = instance_place(x+xdir, y+ydir, obj_speaker);
    if (speaker != noone) 
    {
        /// Talk to it
        with (speaker) 
        {
            if (!instance_exists(dialog)) 
            {
                dialog = instance_create(x+xoffset, y+yoffset, obj_dialog);
                dialog.text = text;
            } 
            else 
            {
                dialog.text_page++;
                dialog.text_count = 0;
                if (dialog.text_page > array_length_1d(dialog.text)-1)
                {
                    with (dialog) 
                    {
                        instance_destroy();
                    }
                }
            }
        }
    } 
    else if (obj_player_stats.stamina >= DASH_COST) 
    {
        // Dash
        state = scr_dash_state;
        alarm[0] = room_speed/6;
        obj_player_stats.stamina -= DASH_COST;
        obj_player_stats.alarm[0] = room_speed*2;
    }
    
}

if (attack_key) {
    image_index = 0;
    state = scr_attack_state;    
}

// Get direction
dir = point_direction(0, 0, xaxis, yaxis);

// Get the length
if (xaxis == 0 && yaxis == 0) {
    len = 0;
} else {
    len = spd;
    scr_get_face();
}

// Get the hspd and vspd
hspd = lengthdir_x(len, dir);
vspd = lengthdir_y(len, dir);

// Move
phy_position_x += hspd;
phy_position_y += vspd;

// Control the sprite
image_speed = .2;
if (len == 0) image_index = 0;

switch (face) {
    case UP:
        sprite_index = spr_player_up;
        break;
    case DOWN:
        sprite_index = spr_player_down;
        break;
    case LEFT:
        sprite_index = spr_player_left;
        break;
    case RIGHT:
        sprite_index = spr_player_right;
        break;
}
