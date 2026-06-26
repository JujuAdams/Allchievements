if (not ALLCH_USING_GDK)
{
    return;
}

if (ALLCH_VERBOSE_ASYC)
{
    __AllchTrace($"System (via `ALLCH_VERBOSE_ASYC`): {json_encode(async_load, true)}");
}

with(__AllchSystem())
{
    if (async_load[? "id"] == achievement_stat_event)
    {
        if (async_load[? "event_type"] == "achievements info")
        {
            if (ds_map_exists(__xboxCachedMap, __xboxUser))
            {
                __AllchWarning("Already cached achievements for user {__xboxUser}");
                return;
            }
            
            //We only try to get cached achievements once
            __xboxCachedMap[? __xboxUser] = true;
            
            if (async_load[? "error"] != 0)
            {
                __AllchWarning($"Received error `{async_load[? "error"]}` when getting achievements for user {__xboxUser}. Falling back on resubmission");
                return;
            }
            
            if (not async_load[? "succeeded"])
            {
                __AllchWarning($"Getting achievements for user {__xboxUser} returned as unsuccessful. Falling back on resubmission");
                return;
            }
            
            var _array = async_load[? "achievements"];
            if (not is_array(_array))
            {
                __AllchWarning($"Achievements for user {__xboxUser} returned invalid data (not an array). Falling back on resubmission");
                return;
            }
            
            var _cacheDict = __xboxAchievementsCache[? __xboxUser];
            var _i = 0;
            repeat(array_length(_array))
            {
                var _achievementData = _array[_i];
                var _id = _achievementData[$ "id"];
                
                if (_id != undefined)
                {
                    _id = string(_id);
                    
                    if (_achievementData[$ "progressState"] == xboxone_achievement_progress_unlocked)
                    {
                        if (ALLCH_VERBOSE)
                        {
                            __AllchTrace($"Achievement `{_id}` unlocked for user {__xboxUser}");
                        }
                        
                        _cacheDict[$ _id] = true;
                    }
                }
                
                ++_i;
            }
        }
    }
}