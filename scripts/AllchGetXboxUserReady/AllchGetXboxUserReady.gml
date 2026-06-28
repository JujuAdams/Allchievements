/// Returns if the Xbox user is ready for use. When running on a non-GDK platform (or on Windows
/// without the GDK extension set up), this function will always return `true`.

function AllchGetXboxUserReady()
{
    static _system = __AllchSystem();
    
    if (not ALLCH_USING_GDK)
    {
        return true;
    }
    
    with(_system.__currentPlayer)
    {
        return __ready;
    }
    
    return false;
}