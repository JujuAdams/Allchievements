/// @param playerID

function __AllchEnsurePlayer(_playerID)
{
    static _playerMap = __AllchSystem().__playerMap;
    
    var _playerStruct = _playerMap[? _playerID];
    if (not is_struct(_playerStruct))
    {
        _playerStruct = new __AllchClassPlayer(_playerID);
        _playerMap[? _playerID] = _playerStruct;
    }
    
    return _playerStruct;
}