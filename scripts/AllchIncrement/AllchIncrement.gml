/// @param identifier
/// @param value

function AllchIncrement(_identifier, _value)
{
    return AllchSetValue(_identifier, AllchGetValue(_identifier) + _value);
}