/// Returns whether an achievement is set as hidden.
/// 
/// @param identifier

function AllchGetHidden(_identifier)
{
    static _system    = __AllchSystem();
    static _configMap = _system.__configMap;
    
    if (AllchGetUnlocked(_identifier))
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