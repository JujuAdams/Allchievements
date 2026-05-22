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
/// If offline achievements are being used (as indicated by `ALLCH_USING_OFFLINE`) then this
/// function will return `true` if an achievement is newly unlocked. This positive return
/// value could be used to trigger an in-game notification etc.
/// 
/// @param identifier

function AllchUnlock(_identifier)
{
    static _system    = __AllchSystem();
    static _configMap = _system.__configMap;
    
    var _config = _configMap[? _identifier];
    if (_config == undefined)
    {
        __AllchSoftError($"Achievement `{_identifier}` not recognised");
        return false;
    }
    
    var _ref = _config.__ref;
    if (_ref == undefined)
    {
        if (ALLCH_VERBOSE)
        {
            __AllchTrace($"Achievement `{_identifier}` is disabled on this platform");
        }
    }
    else if (ALLCH_USING_OFFLINE)
    {
        //Set offline values
        
        if (_system.__offlineDict[$ _ref] != true)
        {
            if (ALLCH_VERBOSE)
            {
                __AllchTrace($"Awarding offline achievement `{_identifier}` (reference `{_ref}`)");
            }
            
            _system.__offlineDict[$ _ref] = true;
            _system.__offlineChanged = true;
            
            return true;
        }
        else
        {
            if (ALLCH_VERBOSE)
            {
                __AllchTrace($"Awarding offline achievement `{_identifier}` but player already has it (reference `{_ref}`)");
            }
        }
    }
    else
    {
        //Send off unlock command to remote service
        
        if (ALLCH_VERBOSE)
        {
            __AllchTrace($"Awarding achievement `{_identifier}` using remote service (reference `{_ref}`)");
        }
        
        if (ALLCH_STEAM_AVAILABLE)
        {
            steam_set_achievement(_ref);
        }
        else if (ALLCH_USING_GDK)
        {
            if (_system.__xboxUser <= int64(0))
            {
                __AllchSoftError("Xbox user not set or invalid. Please set the user with `AllchSetXboxUser()` before calling `AllchUnlock()`");
            }
            else
            {
                xboxone_achievements_set_progress(_system.__xboxUser, _ref, 100);
            }
        }
        else if (ALLCH_ON_PS5)
        {
            if (_system.__psGamepad < 0)
            {
                __AllchSoftError("PlayStation gamepad not set or invalid. Please set the gamepad with `AllchSetPSGamepad()` before calling `AllchUnlock()`");
            }
            else
            {
                psn_unlock_trophy(_system.__psGamepad, _ref);
            }
        }
        else if (ALLCH_USING_GAMECENTER)
        {
            GameCenter_Achievement_Report(_ref, 100, true);
        }
        else if (ALLCH_PLAY_SERVICES_AVAILABLE)
        {
            GooglePlayServices_Achievements_Unlock(_ref);
        }
        else
        {
            __AllchSoftError($"Unhandled OS {os_type}. Please report this error");
        }
    }
    
    return false;
}