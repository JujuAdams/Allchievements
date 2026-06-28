/// @param userID
/// @param achievementRef

function __AllchDequeueXboxAchievement(_userID, _ref)
{
    static _xboxQueue = __AllchSystem().__xboxQueue;
    
    var _queue = _xboxQueue;
    var _i = 0;
    repeat(array_length(_queue))
    {
        var _entry = _queue[_i];
        if ((_entry.__userID == _userID) && (_entry.__ref = _ref))
        {
            array_delete(_queue, _i, 1);
            return;
        }
        
        ++_i;
    }
}