/// @param identifier

function AllchUnlock(_identifier)
{
    return AllchSetValue(_identifier, AllchGetTarget(_identifier));
}