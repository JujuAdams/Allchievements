/// Gets the current gamepad that Allchievements will target when unlocking trophies.

function AllchGetPSGamepad()
{
    static _system = __AllchSystem();
    return (ALLCH_ON_PS5 && is_struct(_system.__currentPlayer))? _system.__currentPlayer.__playerID : -1;
}