/// Sets the state of offline achievements from a struct. The struct should have been created by
/// `AllOfflineExport()`. Offline data will be marked as "unchanged" and future calls to
/// `AllchOfflineGetChanged()` will return `false` until offline data is changed.
/// 
/// @param data

function AllOfflineImport(_data)
{
    static _system = __AllchSystem();
    
    _system.__offlineChanged = false;
    _system.__offlineDict = variable_clone(_data);
}