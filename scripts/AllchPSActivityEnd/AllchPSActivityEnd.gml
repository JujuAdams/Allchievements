/// PlayStation 5 requires that developers implement "activities" that the player can complete.
/// This function ends an activity that has previously been started (typically using
/// `AllchPSActivityStart()`). Please refer to Sony documentation for further details.
/// 
/// @param activityID
/// @param [outcome=completed]
/// @param [score]

function AllchPSActivityEnd(_activityID, _outcome = "completed", _score = undefined)
{
    static _system = __AllchSystem();
    static _psStartedActivityDict = _system.__psStartedActivityDict;
    
	if (ALLCH_ON_PS5)
    {
        if (not is_string(_activityID))
        {
            if (ALLCH_STRICT)
            {
                __AllchError($"`activityID` must be a string");
            }
        }
        else if (_system.__psGamepad < 0)
        {
            __AllchSoftError("PlayStation gamepad not set or invalid. Please set the gamepad with `AllchSetPSGamepad()` before calling `AllchPSActivityEnd()`");
        }
        else if (not struct_exists(_system.__psStartedActivityDict, _activityID))
        {
            if (ALLCH_VERBOSE)
            {
                __AllchWarning($"Activity \"{_activityID}\" has not been started");
            }
        }
        else
        {
            if (ALLCH_VERBOSE)
            {
                __AllchTrace($"Ending activity \"{_activityID}\", outcome = \"{_outcome}\", score = {_score}");
            }
            
            var _map = ds_map_create();
            _map[? "activityId"] = _activityID;
            _map[? "outcome"   ] = _outcome;
            
            if (_score != undefined)
            {
                if (not is_numeric(_score))
                {
                    __AllchSoftError($"Scores must be numbers (was {typeof(_score)}");
                }
                else
                {
                    //Force s32
                    static __buffer = buffer_create(buffer_sizeof(buffer_s32), buffer_fixed, 1);
                    buffer_poke(__buffer, 0, buffer_s32, _score);
                    _map[? "score"] = buffer_peek(__buffer, 0, buffer_s32);
                }
            }
            
            psn_post_uds_event(_system.__psGamepad, "activityEnd", _map);
            ds_map_destroy(_map);
            
            struct_remove(_psStartedActivityDict, _activityID);
        }
    }
}