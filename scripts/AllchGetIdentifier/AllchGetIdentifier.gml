function AllchGetIdentifier(_index)
{
    static _configOrder = __AllchSystem().__configOrder;
    
    if ((_index < 0) || (_index >= array_length(_configOrder)))
    {
        return undefined;
    }
    
    return _configOrder[_index];
}