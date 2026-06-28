/// Gets the current gamepad that Allchievements will target when unlocking achievements.

function AllchGetXboxUser()
{
    static _system = __AllchSystem();
    return (ALLCH_USING_GDK && is_struct(_system.__currentPlayer))? _system.__currentPlayer.__playerID : undefined;
}