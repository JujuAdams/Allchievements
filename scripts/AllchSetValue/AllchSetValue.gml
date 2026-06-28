/// Unlocks the achievement associated with the given achivement identifier. You should first have
/// created the achivement with `AllchCreate()` in the `__AllchConfig` script.
/// 
/// N.B. You must call `AllchSetPSGamepad()` or `AllchSetXboxUser()` before unlocking achievements
///      on PlayStation or Xbox.
/// 
/// N.B. Allchievements does not call `psn_tick()` for you when running on PlayStation. You must
///      call this functions yourself.
/// 
/// N.B. Allchievements does not call `gdk_init()`, `gdk_update()`, or `gdk_quit()` for you when
///      running on WIndows using the Xbox GDK extension. You must call these functions yourself.
/// 
/// This function will return `true` if an achievement is newly unlocked. This positive return
/// value could be used to trigger an in-game notification etc.
/// 
/// @param identifier
/// @param value

function AllchSetValue(_identifier, _value)
{
    static _system = __AllchSystem();
    
    with(_system)
    {
        if (_system.__currentPlayer == undefined)
        {
            __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
            return false;
        }
        
        return __currentPlayer.__SetValue(_identifier, _value);
    }
    
    return false;
}