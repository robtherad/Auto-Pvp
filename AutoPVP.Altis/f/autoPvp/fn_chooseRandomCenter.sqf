// Randomly generate a position on the map that's somewhat flat and not on the water.
private _randomCordX = random (bc_auto_worldSizeArray select 0);
private _randomCordY = random (bc_auto_worldSizeArray select 1);
private _cordArray = [_randomCordX, _randomCordY, 0];

// Make sure the position isn't in the water
if (_cordArray isFlatEmpty [-1, -1, 0.75, 10, 0] isEqualTo []) then {
    diag_log format["AutoPvP DEBUG: Reroll: %1",_cordArray];
    _cordArray = call bc_fnc_chooseRandomCenter;
};
_cordArray
