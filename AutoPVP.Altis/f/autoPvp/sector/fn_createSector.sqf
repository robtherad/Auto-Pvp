/*
Creates sectors and then adds a CBA PFH to poll them.
*/
if (!isServer) exitWith {};

bc_auto_triggerArray = [bc_auto_centralTrigger];

// Initialize variables
private _markerNameIterator = 0;
bc_auto_westPoints = 0;
bc_auto_eastPoints = 0;
bc_auto_playing = true;
bc_auto_sectorControl = true;
missionNamespace setVariable ["bc_auto_sectorControlActive", true, true]; // Used to check if sector control module is running or not

if (isNil "bc_auto_quickestTime") then {
    // Time in minutes it would take to win if one team owned all points uncontested
    bc_auto_quickestTime = ["sc_quickest_ending",25] call BIS_fnc_getParamValue;
};
bc_auto_endPoints = bc_auto_quickestTime * 60 * (count bc_auto_triggerArray);

// Create markers for players to see whats going on
{// forEach bc_auto_triggerArray
    // Get variables for a marker
    private _markerName = str(_markerNameIterator) + "_BCAutoMark";
    private _markerSize = triggerArea _x;
    private _markerPos = getPos _x;

    // Build marker for area
    private _marker = createMarker [_markerName,_markerPos];
    _marker setMarkerSize [_markerSize select 0,_markerSize select 1];
    _marker setMarkerDir (_markerSize select 2);
    _marker setMarkerColor "ColorBlack";
    _marker setMarkerBrush "SolidBorder";
    // Get marker's shape
    if (_markerSize select 3) then {
        _marker setMarkerShape "RECTANGLE";
    } else {
        _marker setMarkerShape "ELLIPSE";
    };

    // Build marker for text
    _markerName = str(_markerNameIterator) + "_BCAutoMarkText";
    _marker = createMarker [_markerName,_markerPos];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "hd_dot";
    _marker setMarkerText (triggerText _x + " - Neutral");

    // Set sector status to neutral for later
    _x setVariable ["bc_auto_curOwner",3];
    _x setVariable ["bc_auto_lastOwner",3];
    _markerNameIterator = _markerNameIterator + 1;
} forEach bc_auto_triggerArray;

// TODO: Balance sector polling time as well as total points goal.
[bc_fnc_watchSector, 10, [bc_auto_triggerArray]] call CBA_fnc_addPerFrameHandler;