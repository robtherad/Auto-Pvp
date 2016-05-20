// Find possible starting locations for teams. Returns empty array if it fails. Returns array with two sets of location coordinates if it works.
params [
    ["_centerPoint", [30000, 30000, 0], [[]], 3],
    ["_centerDistance", 1000, [0]]
];

// Scale the amount of generated positions with the size of the mission area
private _positionGenerations = 64;

// Get a number of positions surrounding the mission's center that could be useful as starting locations
private _testPositionArray = [];
for "_i" from 1 to _positionGenerations do {
    private _dir = (360 / _positionGenerations) * _i;
    _testPositionArray pushBack (_centerPoint getPos [_centerDistance,_dir]);
};

// Filter out positions that wouldn't make good starting areas
private _goodPositionArray = [];
{
    if !(_x isFlatEmpty [-1, -1, 0.75, 25, 0] isEqualTo []) then {
        _goodPositionArray pushBack _x;
    };
} forEach _testPositionArray;

// If there aren't at least two possible team starting locations then return an empty array to signify failure
private _return = [];
if (count _goodPositionArray > 2) then {
    {
        private _returnCount = count _return;
        if (_returnCount isEqualTo 1) then {
            // Make sure distance between two starts is at least the distance from center point to one of the starts. Make sure the starting locations can't see each other.
            if ( _x distance (_return select 0) > _centerDistance*1.5 ) then {
                if ( ([objNull, "VIEW"] checkVisibility [_x, _return select 0]) < .1) then {
                    _return pushBack _x;
                };
            };
        } else {
            if (_returnCount isEqualTo 0) then {
                _return pushBack _x;
            };
        };
    } forEach _goodPositionArray;
};
_return
