/// Returns whether an achievement with the given indentifier has been created.
/// 
/// @param identifier

function AllchExists(_identifier)
{
    static _configMap = __AllchSystem().__configMap;
    
    return ds_map_exists(_configMap, _identifier);
}