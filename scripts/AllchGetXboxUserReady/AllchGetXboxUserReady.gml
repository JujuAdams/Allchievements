/// Returns if the Xbox user is ready for use. When running on a non-GDK platform (or on Windows
/// without the GDK extension set up), this function will always return `true`.

function AllchGetXboxUserReady()
{
    static _system = __AllchSystem();
    static _xboxCachedMap = _system.__xboxCachedMap;
    
    return ALLCH_USING_GDK? (_xboxCachedMap[? _system.__xboxUser] ?? false) : true;
}