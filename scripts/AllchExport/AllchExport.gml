/// Returns a string containing the state of local achievements. You can then save this string
/// into a savefile etc. for importing later.
/// 
/// After you call this function, local data will be marked as "unchanged" and future calls to
/// `AllchGetChanged()` will return `false` (until the local data is changed again).

function AllchExport()
{
    static _system    = __AllchSystem();
    static _configMap = _system.__configMap;
    static _buffer    = buffer_create(1024, buffer_grow, 1);
    
    with(_system)
    {
        if (_system.__currentPlayer == undefined)
        {
            __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
            return "";
        }
    }
    
    with(_system.__currentPlayer)
    {
        __dataChanged = false;
        var _progressMap = __progressMap;
        
        buffer_seek(_buffer, buffer_seek_start, 0);
        
        buffer_write(_buffer, buffer_string, "ALCH");
        buffer_write(_buffer, buffer_u8, __ALLCH_SAVE_VERSION);
        buffer_write(_buffer, buffer_u32, ds_map_size(_progressMap));
        
        var _key = ds_map_find_first(_progressMap);
        repeat(ds_map_size(_progressMap))
        {
            buffer_write(_buffer, buffer_string, _configMap[? _key].local);
            buffer_write(_buffer, buffer_f64, _progressMap[? _key].__value);
            
            _key = ds_map_find_next(_progressMap, _key);
        }
        
        //TODO - Encrypt
        
        return buffer_base64_encode(_buffer, 0, buffer_tell(_buffer));
    }
    
    return "";
}