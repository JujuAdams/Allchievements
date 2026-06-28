/// @param identifier

function AllchGetUnlocked(_identifier)
{
    static _system = __AllchSystem();
    
    with(_system)
    {
        if (_system.__currentPlayer == undefined)
        {
            __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
            return false;
        }
        
        return __currentPlayer.__GetUnlocked(_identifier);
    }
    
    return false;
}