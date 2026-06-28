/// @param identifier

function AllchGetValue(_identifier)
{
    static _system = __AllchSystem();
    
    with(_system)
    {
        if (_system.__currentPlayer == undefined)
        {
            __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
            return 0;
        }
        
        return __currentPlayer.__GetValue(_identifier);
    }
    
    return 0;
}