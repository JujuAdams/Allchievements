function AllchGetCount()
{
    static _configOrder = __AllchSystem().__configOrder;
    
    return array_length(_configOrder);
}