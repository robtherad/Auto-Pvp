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

[{
    params ["_args", "_handle"];
    
    if (!isNil "bc_auto_teamStarts" && {!isNil "bc_auto_centerLocation"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        call bc_fnc_randomStart;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

// Ensure player is supposed to be randomly placed

//Get the position of the placement marker.

// Boundary marker for starting location
private _startMark = createMarkerLocal ["bc_rs_startZone",bc_auto_teamStarts];
_startMark setMarkerShapeLocal "ELLIPSE";
_startMark setMarkerSizeLocal [50, 50];
_startMark setMarkerBrushLocal "SolidBorder";
_startMark setMarkerColorLocal _color;

// Text marker for starting location
private _startMarkTwo = createMarkerLocal ["bc_rs_startZoneTwo",bc_auto_teamStarts];
_startMarkTwo setMarkerShapeLocal "ICON";
_startMarkTwo setMarkerColorLocal "ColorBlack";
_startMarkTwo setMarkerTypeLocal "hd_dot";
_startMarkTwo setMarkerTextLocal _text;

//Find player distance and direction to the placement marker.
private _dis = player distance2D bc_auto_centerLocation;
private _dir = ((player getDir bc_auto_centerLocation) + (markerDir _randomMarker)) - 180;

//Returns a position that is a specified distance and compass direction from the passed position or object.
private _newPos = bc_auto_teamStarts getPos [_dis, _dir];

//Move player
player setPos [(_newPos select 0), (_newPos select 1)];
player setDir (player getDir bc_auto_centerLocation);
    
    
// Add a PFH that will pop up a warning for the player
// TODO: Add blinding mechanic here? - cutText ["","BLACK OUT",1,false];
[{
    params ["_args", "_handle"];
    
    if (time > 0) then {
        titleText ["Your team has been started in a location unknown to the enemy.\n\nDO NOT fire your weapon during safe start or the enemy will know where you are.","PLAIN DOWN", 1.5];
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        [{
            params ["_args", "_handle"];
            
            "bc_auto_mapBlackOut" cutText ["","BLACK OUT",1,false];
            if (bc_safeStartOver) then {
                "bc_auto_mapBlackOut" cutText ["","PLAIN DOWN",0.1,false];
            };
        }, 2, []] call CBA_fnc_addPerFrameHandler;
    };
}, 2, []] call CBA_fnc_addPerFrameHandler;
