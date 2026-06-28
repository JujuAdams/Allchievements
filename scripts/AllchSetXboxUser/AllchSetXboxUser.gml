/// Sets the user that has unlocked an achievement. You should call this function at least once
/// before calling `AllchAward()`.
/// 
/// @param xboxUser

function AllchSetXboxUser(_xboxUser)
{
    static _system = __AllchSystem();
    
    if (ALLCH_USING_GDK)
    {
        _xboxUser = int64(_xboxUser);
        
        if (_xboxUser != AllchGetXboxUser())
        {
            if (ALLCH_VERBOSE)
            {
                __AllchTrace($"Set Xbox user to {_xboxUser}");
            }
        }
        
        if (_xboxUser <= 0)
        {
            _system.__currentPlayer = undefined;
        }
        else
        {
            _system.__currentPlayer = __AllchEnsurePlayer(_xboxUser);
        }
    }
}