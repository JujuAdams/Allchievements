/// PlayStation 5 requires that developers implement "activities" that the player can complete.
/// This function starts an activity that you have defined in the UDS backend. Please refer to
/// Sony documentation for further details.
/// 
/// @param activityID

function AllchPSActivityStart(_activityID)
{
    static _system = __AllchSystem();
    static _psStartedActivityDict = _system.__psStartedActivityDict;
    
	if (ALLCH_ON_PS5)
    {
        var _psGamepad = AllchGetPSGamepad();
        
        if (not is_string(_activityID))
        {
            if (ALLCH_STRICT)
            {
                __AllchError($"`activityID` must be a string");
            }
        }
        else if (_psGamepad < 0)
        {
            __AllchSoftError("PlayStation gamepad not set or invalid. Please set the gamepad with `AllchSetPSGamepad()` before calling `AllchPSStartActivity()`");
        }
        else if (struct_exists(_system.__psStartedActivityDict, _activityID))
        {
            if (ALLCH_VERBOSE)
            {
                __AllchWarning($"Activity \"{_activityID}\" has already been started");
            }
        }
        else
        {
            if (ALLCH_VERBOSE)
            {
                __AllchTrace($"Starting activity \"{_activityID}\"");
            }
            
            var _map = ds_map_create();
            _map[? "activityId"] = _activityID;
            psn_post_uds_event(_psGamepad, "activityStart", _map);
            ds_map_destroy(_map);
            
            _psStartedActivityDict[$ _activityID] = true;
        }
    }
}