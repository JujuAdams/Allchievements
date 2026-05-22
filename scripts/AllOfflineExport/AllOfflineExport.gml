/// Returns a struct containing the state of offline achievements. Offline data will be marked as
/// "unchanged" and future calls to `AllchOfflineGetChanged()` will return `false` until offline
/// data is changed.

function AllOfflineExport()
{
    static _system = __AllchSystem();
    
    _system.__offlineChanged = false;
    return variable_clone(_system.__offlineDict);
}