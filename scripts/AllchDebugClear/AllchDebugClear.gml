function AllchDebugClear()
{
    static _system = __AllchSystem();
    
    if (_system.__currentPlayer == undefined)
    {
        __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
        return false;
    }
    
    with(_system.__currentPlayer)
    {
        __dataChanged = false;
        ds_map_clear(__progressMap);
        
        __AllchWarning($"Progress cleared (user ID = {__playerID})");
    }
}