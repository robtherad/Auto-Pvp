/*
Randomly generate coordinates until one is found that is reasonably flat and not on water.
*/
private _flatEmptyArray = param [0];

private _randomCordX = random (phx_auto_worldSizeArray select 0);
private _randomCordY = random (phx_auto_worldSizeArray select 1);
private _cordArray = [_randomCordX, _randomCordY, 0];

// Make sure the position isn't in the water
if (_cordArray isFlatEmpty _flatEmptyArray isEqualTo []) then {
    _cordArray = [_flatEmptyArray] call phx_fnc_chooseRandomCenter;
};
_cordArray
