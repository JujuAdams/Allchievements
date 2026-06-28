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
            var _userID = undefined;
            
            try
            {
                _userID = int64(async_load[? "userID"]);
            }
            catch(_error)
            {
                
            }
            
            if (_userID == undefined)
            {
                __AllchSoftError($"Failed to parse user ID (typeof = {async_load[? "userID"]})");
                return;
            }
            
            var _playerStruct = __AllchEnsurePlayer(_userID);
            if (_playerStruct.__ready)
            {
                __AllchWarning($"Already received achievements for user {_userID}");
                return;
            }
            
            _playerStruct.__ready = true;
            
            if (async_load[? "error"] != 0)
            {
                __AllchWarning($"Received error `{async_load[? "error"]}` when getting achievements for user {_userID}");
                return;
            }
            
            if (not async_load[? "succeeded"])
            {
                __AllchWarning($"Getting achievements for user {_userID} returned as unsuccessful");
                return;
            }
            
            var _array = async_load[? "achievements"];
            if (not is_array(_array))
            {
                __AllchWarning($"Achievements for user {_userID} returned invalid data (not an array)");
                return;
            }
            
            var _i = 0;
            repeat(array_length(_array))
            {
                var _achievementData = _array[_i];
                var _id = _achievementData[$ "id"];
                
                var _identifier = __xboxReferenceToIdent[? _id];
                if (_identifier == undefined)
                {
                    __AllchWarning($"Could not find local achievement definition for reference `{_id}`");
                }
                else
                {
                    var _dataStruct = _playerStruct.__EnsureProgress(_identifier);
                    
                    if (_achievementData[$ "progressState"] == xboxone_achievement_progress_unlocked)
                    {
                        if (ALLCH_VERBOSE)
                        {
                            __AllchTrace($"Achievement `{_identifier}` unlocked for user {_userID}");
                        }
                        
                        _dataStruct.__unlocked = true;
                        _dataStruct.__existingPercentage = 100;
                    }
                    else
                    {
                        var _existingPercentage = undefined;
                        try
                        {
                            var _requirement = _achievementData.progression.requirements[0];
                            var _currentProgress = real(_requirement.currentProgressValue);
                            var _targetProgress = real(_requirement.targetProgressValue);
                            _existingPercentage = 100*(_currentProgress / _targetProgress);
                        }
                        catch(_error)
                        {
                        
                        }
                        
                        if (_existingPercentage != undefined)
                        {
                            _dataStruct.__existingPercentage = floor(_existingPercentage) + 1;
                            
                            if (ALLCH_VERBOSE)
                            {
                                __AllchTrace($"Achievement `{_identifier}` existing percentage is {_existingPercentage}% for user {_userID}");
                            }
                        }
                    }
                }
                
                ++_i;
            }
        }
    }
}