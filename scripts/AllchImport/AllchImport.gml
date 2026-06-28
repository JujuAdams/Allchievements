/// Sets the state of local achievements from a string. The string must have been created by
/// `AllExport()`.
/// 
/// After you call this function, local data will be marked as "unchanged" and future calls to
/// `AllchGetChanged()` will return `false` (until the local data is changed again).
/// 
/// @param string

function AllchImport(_string)
{
    static _system = __AllchSystem();
    static _localToIdentifierDict = _system.__localToIdentifierDict;
    
    if (_system.__currentPlayer == undefined)
    {
        __AllchError("No player set. Please call `AllchSetPSGamepad()` or `AllchSetXboxUser()` as appropriate");
        return false;
    }
    
    with(_system.__currentPlayer)
    {
        __dataChanged = false;
        
        var _buffer = buffer_base64_decode(_string);
        
        // TODO - Decrypt
        
        var _header = buffer_read(_buffer, buffer_string);
        if (_header != "ALCH")
        {
            throw "Invalid header";
        }
        
        var _version = buffer_read(_buffer, buffer_u8);
        if (_version != 1)
        {
            throw $"Unsupported save version {_version}";
        }
        
        var _count = buffer_read(_buffer, buffer_u32);
        repeat(_count)
        {
            var _local = buffer_read(_buffer, buffer_string);
            var _value = buffer_read(_buffer, buffer_f64);
            
            var _identifier = _localToIdentifierDict[$ _local];
            if (not is_numeric(_identifier))
            {
                __AllchWarning($"Local name \"{_local}\" not recognized");
            }
            else
            {
                AllchSetMax(_identifier, _value);
            }
        }
    }
}