/*
Searches in a circle around the central sector for two starting locations for teams. The starting locations must be on land, be fairly free of obstacles, and not be in sight of each other.

Returns: An array of suitable locations for teams to start at. Can return 0, 1, or 2 locations at a time.

Runs on server.
*/

// Scale the amount of generated positions with the size of the mission area
private _positionGenerations = 48;


// Get a number of positions surrounding the mission's center that could be useful as starting locations
private _testPositionArray = [];
for "_i" from 1 to _positionGenerations do {
    private _dir = (360 / _positionGenerations) * _i;
    _testPositionArray pushBack (phx_auto_centerLocation getPos [phx_auto_missionScale,_dir]);
};

// Filter out positions that wouldn't make good starting areas
private _goodPositionArray = [];
{
    if !(_x isFlatEmpty [7, -1, -1, -1, 0] isEqualTo []) then {
        _goodPositionArray pushBack _x;
    };
} forEach _testPositionArray;

// If there aren't at least two possible team starting locations then return an empty array to signify failure
private _return = [];
if (count _goodPositionArray > 2) then {
    _goodPositionArray = [_goodPositionArray] call CBA_fnc_shuffle;
    { 
        private _returnCount = count _return;
        if (_returnCount isEqualTo 2) exitWith {};
        if (_returnCount isEqualTo 1) then {
            private _teamOnePos = _return select 0;
            // Make sure distance between two starts is at least the distance from center point to one of the starts. Make sure the starting locations can't see each other.
            if ( _x distance _teamOnePos > phx_auto_missionScale*1.5 ) then {
                if ( ([objNull, "VIEW"] checkVisibility [_x,_teamOnePos]) < .1) then {
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
