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
                
                if (_identifier != undefined)
                {
                    var _dataStruct = _playerStruct.__EnsureProgress(_identifier);
                    
                    if (_achievementData[$ "progressState"] == xboxone_achievement_progress_unlocked)
                    {
                        if (ALLCH_VERBOSE)
                        {
                            __AllchTrace($"Achievement `{_identifier}` __unlocked for user {_userID}");
                        }
                        
                        _dataStruct[$ _id] = true;
                    }
                    
                    var _newValue = 0;
                    
                    var _progressionStruct = _achievementData[$ "progressState"];
                    if (is_struct(_progressionStruct))
                    {
                        try
                        {
                            _newValue = real(_progressionStruct[$ "currentProgressValue"]);
                        }
                        catch(_error)
                        {
                            
                        }
                    }
                    
                    if ((_newValue != undefined) && (_newValue > _dataStruct.__value))
                    {
                        _dataStruct.__value = _newValue;
                        
                        if (ALLCH_VERBOSE)
                        {
                            __AllchTrace($"Achievement `{_identifier}` __value is {_newValue} for user {_userID}");
                        }
                    }
                }
                
                ++_i;
            }
        }
    }
}