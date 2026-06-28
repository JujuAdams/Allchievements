/// @param identifier

function AllchGetTarget(_identifier)
{
    static _system    = __AllchSystem();
    static _configMap = _system.__configMap;
    
    var _config = _configMap[? _identifier];
    if (_config == undefined)
    {
        __AllchSoftError($"Achievement `{_identifier}` not recognised");
        return 1;
    }
    
    return _config.target;
}