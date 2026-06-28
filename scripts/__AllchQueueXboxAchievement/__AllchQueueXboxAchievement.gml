/// @param userID
/// @param achievementRef
/// @param percentage

function __AllchQueueXboxAchievement(_userID, _ref, _percentage)
{
    static _xboxQueue = __AllchSystem().__xboxQueue;
    
    __AllchDequeueXboxAchievement(_userID, _ref);
    array_push(_xboxQueue, { __userID: _userID, __ref: _ref, __percentage: _percentage });
}