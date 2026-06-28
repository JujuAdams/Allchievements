/// Returns if the Xbox user is ready for use. When running on a non-GDK platform (or on Windows
/// without the GDK extension set up), this function will always return `true`.

function AllchGetXboxUserReady()
{
    static _system = __AllchSystem();
    
    if (not ALLCH_USING_GDK)
    {
        return true;
    }
    
    with(_system)
    {
        if (_system.__currentPlayer == undefined)
        {
            __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
            return 0;
        }
        
        return __currentPlayer.__ready;
    }
    
    return true;
}