/// Defines a link between an achievement identifier and external services. This function should
/// only be called in `__AllchConfigOnBoot()` which is found in the `__AllchConfig` script. You may
/// use a string or an integer for the achivement identifier; however, it is recommended that you
/// make use of the `ALLCH_IDENT` enum found at the top of `__AllchConfigOnBoot()`.
/// 
/// The `config` parameter must be a struct that contains definitions for each service that you
/// wish to use for achivements tracking. Each platform that you intend to use must have a value
/// in the configuration struct. If you wish to disable an achivement on a given platform, set the
/// value for that platform to `undefined`. If you wish to disable an achivement for all platforms,
/// use `undefined` in place of the config struct itself.
/// 
/// Exactly what value is needed depends on the platform. Please refer to platform/SDK documentation
/// for official information. However, the following is a brief guide:
/// 
/// Local Data: `.local`
///   This value must be a string. Local data is used on all platforms.
/// 
/// N.B. Once used, the local value must never be changed after a game has been published. The
///      local value must correlate between versions of the game otherwise players will lose game
///      progress.
/// 
/// Steam: `.steam`
///   This must be a string that is the name of the achievement as set in the Steamworks
///   backend. You may optionally use `"~"` as the value for Steam. This will instead use the
///   achivement identifier as the Steam value. This feature is helpful when porting a Steam game
///   to other platforms as it reduces the amount of refactoring needed.
/// 
/// Switch & Switch 2:
///   Nintendo Switch has no native achievement system.
/// 
/// PlayStation: `.playStation`
///   This value must be an integer that is the index of the trophy as set in the UDS backend.
///   Since a platinum trophy is usually index `0`, trophy indexes tend to start at `1`.
///
/// N.B. You do not need to define platinum trophies when using Allchievements. PlayStation handles
///      awarding platinum trophies automatically.
/// 
/// Xbox / Windows GDK: `.xbox`
///    This value must be a string that is the achievement index as set in the Microsoft Partner
///    Center backend, but stored as a string. For example, achievement index `7` would be `"7"`.
/// 
/// iOS / GameCenter: `.gameCenter`
///   This value must be a string that is the achivement ID as set in the GameCenter backend.
/// 
/// Android / Google Play Services: `.playServices`
///   This value must be a string that is the achivement ID as set in the Play Services backend.
/// 
/// @param identifier
/// @param config

function AllchCreate(_identifier, _config)
{
    static _system                = __AllchSystem();
    static _configMap             = _system.__configMap;
    static _configOrder           = _system.__configOrder;
    static _xboxReferenceToIdent  = _system.__xboxReferenceToIdent;
    static _localToIdentifierDict = _system.__localToIdentifierDict;
    
    if (not _system.__onBoot)
    {
        __AllchSoftError("`AllchCreate()` must only be called in `__AllchConfigOnBoot()`");
        return;
    }
    
    if (ds_map_exists(_configMap, _identifier))
    {
        __AllchError($"Achievement `{_identifier}` already exists");
    }
    
    if (not is_struct(_config))
    {
        __AllchError("Achievement configuration must be a struct");
    }
    
    static _funcCheckIsString = function(_struct, _variableName)
    {
        if (not struct_exists(_struct, _variableName))
        {
            __AllchSoftError($"Parameter `.{_variableName}` missing from {_struct}");
            return false;
        }
        
        var _value = _struct[$ _variableName];
        if ((not is_string(_value)) && (_value != undefined))
        {
            __AllchSoftError($"Parameter `.{_variableName}` must be a string (from {_struct})");
            return false;
        }
        
        return true;
    }
    
    static _funcCheckIsNumber = function(_struct, _variableName)
    {
        if (not struct_exists(_struct, _variableName))
        {
            __AllchSoftError($"Parameter `.{_variableName}` missing from {_struct}");
            return false;
        }
        
        var _value = _struct[$ _variableName];
        if ((not is_numeric(_value)) && (_value != undefined))
        {
            __AllchSoftError($"Parameter `.{_variableName}` must be a number (from {_struct})");
            return false;
        }
        
        return true;
    }
    
    if (not _funcCheckIsString(_config, "local")) return;
    _localToIdentifierDict[$ _config.local] = _identifier;
    
    //Ensure .hidden is set
    _config[$ "hidden"] ??= false;
    _config[$ "target"] ??= 1;
    
    if (ALLCH_USING_STEAMWORKS)
    {
        if (not _funcCheckIsString(_config, "steam")) return;
        
        if (_config.steam == "~")
        {
            _config.steam = _identifier;
        }
    }
    else if (ALLCH_ON_PS5)
    {
        if (not _funcCheckIsNumber(_config, "playStation")) return;
    }
    else if (ALLCH_USING_GDK)
    {
        if (not _funcCheckIsString(_config, "xbox")) return;
        
        if (_config.xbox != undefined)
        {
            _xboxReferenceToIdent[? _config.xbox] = _identifier;
        }
    }
    else if (ALLCH_USING_PLAY_SERVICES)
    {
        if (not _funcCheckIsString(_config, "playServices")) return;
    }
    else if (ALLCH_USING_GAMECENTER)
    {
        if (not _funcCheckIsString(_config, "gameCenter")) return;
    }
    
    if (ALLCH_VERBOSE)
    {
        __AllchTrace($"Creating achievement `{_identifier}` as {_config}");
    }
    
    _configMap[? _identifier] = _config;
    array_push(_configOrder, _identifier);
}