/*
Randomly generate coordinates until one is found that is reasonably flat and not on water.
*/
private _randomCordX = random (bc_auto_worldSizeArray select 0);
private _randomCordY = random (bc_auto_worldSizeArray select 1);
private _cordArray = [_randomCordX, _randomCordY, 0];

// Make sure the position isn't in the water
if (_cordArray isFlatEmpty [25, -1, 0.9, 10, 0] isEqualTo []) then {
    _cordArray = call bc_fnc_chooseRandomCenter;
};
_cordArray
