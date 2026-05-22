/// Returns whether an offline achivement is hidden.
/// 
/// @param identifier

function AllchOfflineGetHidden(_identifier)
{
    static _system    = __AllchSystem();
    static _configMap = _system.__configMap;
    
    if (AllchOfflineGetUnlocked(_identifier))
    {
        return false;
    }
    
    var _config = _configMap[? _identifier];
    if (_config == undefined)
    {
        __AllchSoftError($"Achievement `{_identifier}` not recognised");
        return true;
    }
    
    return _config.hidden;
}