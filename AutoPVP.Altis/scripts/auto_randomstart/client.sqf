/*
This script will allow a team to be randomly placed at one of any predetermined markers.

For this script to be effective you will need at least three markers. One marker must be called 'placemark' and must be placed near the team that you wish to be moved. The other two markers can be called anything you want but they must be defined in the server.sqf file in the _markerArray on line 18. If you wish to change the team being moved, change the _ranTeam variable on line 18 in the client.sqf file.

This file receives the randomly selected marker's name from the server and then grabs his position relative to a marker called 'placemark' and places him in the same position relative to the randomly selected marker.

Call this file on ALL CLIENTS from init.sqf using the command below.

[] execVM "scripts\randomstart\client.sqf";

DO NOT FORGET TO CALL THE SERVER SIDE OF THIS SCRIPT FROM INIT.SQF!

[] execVM "scripts\randomstart\server.sqf";
*/
if (isDedicated) exitWith {};
private ["_randomizeTeam","_randomMarkVar","_placemark","_text","_color","_placeMarkerPos","_randomMarker","_startMarkerPos","_startMark","_startMarkTwo","_dis","_dir","_newPos"];

[{
    params ["_args", "_handle"];
    
    if (!isNil "bc_auto_teamStarts") then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        call bc_fnc_randomStart;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

// Ensure player is supposed to be randomly placed
if (_randomizeTeam) then {
    //Get the position of the placement marker.
    if (_placemark isEqualType "") then {
        _placeMarkerPos = getMarkerPos _placemark;
    } else {
        if (_placemark isEqualType []) then {
            _placeMarkerPos = _placemark;
        };
    };
    
    //Wait for server to select a marker from the list.
    waitUntil {
        if (isNil "_randomMarker") then {
            switch (side player) do {
            case west: {_randomMarker = missionNamespace getVariable ["bc_rs_WestMark",nil];};
            case east: {_randomMarker = missionNamespace getVariable ["bc_rs_EastMark",nil];};
            case independent: {_randomMarker = missionNamespace getVariable ["bc_rs_GuerMark",nil];};
            };
            false
        } else {true};
    };
    if (_randomMarker isEqualType "") then {
        _startMarkPos = getMarkerPos _randomMarker;
    } else {
        if (_randomMarker isEqualType []) then {
            _startMarkPos = _randomMarker;
        };
    };
    _startMarkPos = getMarkerPos _randomMarker;

    //Boundary marker for starting location
    _startMark = createMarkerLocal ["bc_rs_startZone",_startMarkPos];
    _startMark setMarkerShapeLocal "ELLIPSE";
    _startMark setMarkerSizeLocal [50, 50];
    _startMark setMarkerDirLocal (markerDir _randomMarker);
    _startMark setMarkerBrushLocal "SolidBorder";
    _startMark setMarkerColorLocal _color;
    //Text marker for starting location
    _startMarkTwo = createMarkerLocal ["bc_rs_startZoneTwo",_startMarkPos];
    _startMarkTwo setMarkerShapeLocal "ICON";
    _startMarkTwo setMarkerColorLocal "ColorBlack";
    _startMarkTwo setMarkerTypeLocal "hd_dot";
    _startMarkTwo setMarkerDirLocal (markerDir _randomMarker);
    _startMarkTwo setMarkerTextLocal _text;

    //Find player distance and direction to the placement marker.
    _dis = player distance2D _placeMarkerPos;
    _dir = ((player getDir _placeMarkerPos) + (markerDir _randomMarker)) - 180;

    //Returns a position that is a specified distance and compass direction from the passed position or object.
    _newPos = _startMarkPos getPos [_dis, _dir];

    //Move player
    player setPos [(_newPos select 0), (_newPos select 1)];
    player setDir (markerDir _randomMarker);

    waitUntil {time > 0;};
    titleText ["Your team has been started in a location unknown to the enemy.\n\nDO NOT fire your weapon during safe start or the enemy will know where you are.","PLAIN DOWN", 1.5];
};
if (!isNil "bc_rs_WestMark") then {diag_log format["[randomstart] BLUFOR started at = %1",bc_rs_WestMark];};
if (!isNil "bc_rs_EastMark") then {diag_log format["[randomstart] REDFOR started at = %1",bc_rs_EastMark];};
if (!isNil "bc_rs_GuerMark") then {diag_log format["[randomstart] GREENFOR started at = %1",bc_rs_GuerMark];};
