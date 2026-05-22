/// Returns whether a locally stored achievement has been unlocked or not.
/// 
/// @param identifier

function AllchOfflineGetUnlocked(_identifier)
{
    static _system    = __AllchSystem();
    static _configMap = _system.__configMap;
    
    var _struct = _configMap[? _identifier];
    if (_struct == undefined)
    {
        __AllchSoftError($"Achievement `{_identifier}` not recognised");
        return false;
    }
    
    return _system.__offlineDict[$ _struct.offline] ?? false;
}