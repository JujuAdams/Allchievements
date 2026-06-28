/// @param identifier
/// @param value

function AllchSetMax(_identifier, _value)
{
    if (_value > AllchGetValue(_identifier))
    {
        AllchSetValue(_identifier, _value);
    }
}