/// Sets the user that has unlocked an achievement. You should call this function at least once
/// before calling `AllchAward()`.
/// 
/// @param xboxUser

function AllchSetXboxUser(_xboxUser)
{
    static _system = __AllchSystem();
    static _xboxAchievementsCache = _system.__xboxAchievementsCache;
    
    if (ALLCH_USING_GDK)
    {
        _xboxUser = int64(_xboxUser);
        _system.__xboxUser = _xboxUser;
        
        if (_xboxUser != 0)
        {
            //If we haven't tried to collect achievements for this user yet, start now
            if (not ds_map_exists(_xboxAchievementsCache, _xboxUser))
            {
                _xboxAchievementsCache[? _xboxUser] = {};
                xboxone_get_achievements(_xboxUser);
            }
        }
        
        if (ALLCH_VERBOSE)
        {
            __AllchTrace($"Set Xbox user to {_xboxUser}");
        }
    }
}