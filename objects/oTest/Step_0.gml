gdk_update();
psn_tick();
steam_update();

var _i = 0;
repeat(gamepad_get_device_count())
{
    if (gamepad_button_check_pressed(_i, gp_face1))
    {
        show_debug_message($"Found input from gamepad {_i}");
        
        gamepad = _i;
        AllchSetPSGamepad(_i);
        
        if (xboxone_user_for_pad(_i) > 0)
        {
            AllchSetXboxUser(xboxone_user_for_pad(_i));
        }
    }
    
    ++_i;
}

if (keyboard_check_pressed(ord("1")) || gamepad_button_check_pressed(gamepad, gp_padu))
{
    AllchUnlock(ALLCH_ACH.SHINY_MACGUFFIN);
}

if (keyboard_check_pressed(ord("2")) || gamepad_button_check_pressed(gamepad, gp_padr))
{
    AllchIncrement(ALLCH_ACH.SLAY_FIVE_RATS, 1);
}

if (keyboard_check_pressed(ord("3")) || gamepad_button_check_pressed(gamepad, gp_padd))
{
    AllchUnlock(ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE);
}

if (keyboard_check_pressed(ord("4")) || gamepad_button_check_pressed(gamepad, gp_padl))
{
    AllchUnlock(ALLCH_ACH.WACKY_NPC_INTERACTION);
}

if (keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(gamepad, gp_start))
{
    var _string = AllchExport();
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    buffer_save(_buffer, "allch.dat");
    buffer_delete(_buffer);
    
    show_debug_message("Saved `allch.dat`");
}

if (keyboard_check_pressed(ord("I")) || gamepad_button_check_pressed(gamepad, gp_select))
{
    if (not file_exists("allch.dat"))
    {
        show_debug_message("`allch.dat` does not exist");
    }
    else
    {
        var _buffer = buffer_load("allch.dat");
        var _string = buffer_read(_buffer, buffer_text);
        buffer_delete(_buffer);
        
        AllchImport(_string);
    }
}

if (keyboard_check_pressed(ord("C")) || gamepad_button_check_pressed(gamepad, gp_face4))
{
    AllchDebugClear();
}