/// Returns whether local achivement data has changed. If the optional `reset` parameter is set
/// to `true` then local data will be marked as "unchanged" and future calls to this function
/// will return `false` until local data changes again.
/// 
/// @param [reset=false]

function AllchGetChanged(_reset = false)
{
    static _system = __AllchSystem();
    
    var _result = false;
    
    with(_system.__currentPlayer)
    {
        _result = __dataChanged;
        if (_reset) __dataChanged = false;
    }
    
    return _result;
}