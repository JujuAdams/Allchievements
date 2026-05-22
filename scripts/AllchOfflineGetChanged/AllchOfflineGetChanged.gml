/// Returns whether offline achivement data has changed. If the optional `reset` parameter is set
/// to `true` then offline data will be marked as "unchanged" and future calls to this function
/// will return `false` until offline data changes again.
/// 
/// @param [reset=false]

function AllchOfflineGetChanged(_reset = false)
{
    static _system = __AllchSystem();
    
    var _result = _system.__offlineChanged;
    if (_reset) _system.__offlineChanged = false;
    return _result;
}