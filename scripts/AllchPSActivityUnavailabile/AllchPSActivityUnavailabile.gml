/// @param activityID

function AllchPSActivityUnavailabile(_activityID)
{
    static _system = __AllchSystem();
    
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
        else
        {
            if (ALLCH_VERBOSE)
            {
                __AllchTrace($"Making activity \"{_activityID}\" unavailable");
            }
            
            var _list = ds_list_create();
            ds_list_add(_list, _activityID);
            
            var _map = ds_map_create();
            _map[? "mode"] = "delta";
            _map[? "unavailableActivities"] = [_activityID];
            
            psn_post_uds_event(_psGamepad, "activityAvailabilityChange", _map);
            ds_map_destroy(_map);
        }
    }
}