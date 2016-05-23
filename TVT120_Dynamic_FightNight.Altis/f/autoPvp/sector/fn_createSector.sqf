/*
Creates sectors and then adds a CBA PFH to poll them.
*/
if (!isServer) exitWith {};

phx_auto_triggerArray = [phx_auto_centralTrigger];

// Initialize variables
private _markerNameIterator = 0;
phx_auto_westPoints = 0;
phx_auto_westPointsPublic = 0;

phx_auto_eastPoints = 0;
phx_auto_eastPointsPublic = 0;

phx_auto_playing = true;
phx_auto_sectorControl = true;
missionNamespace setVariable ["phx_auto_sectorControlActive", true, true]; // Used to check if sector control module is running or not
private _delay = 10; // Delay between each poll

if (isNil "phx_auto_quickestTime") then {
    // Time in minutes it would take to win if one team owned all points uncontested
    phx_auto_quickestTime = ["phx_auto_sectorTime",25] call BIS_fnc_getParamValue;
};
phx_auto_endPoints = (phx_auto_quickestTime * 60) * _delay;

// Create markers for players to see whats going on
{// forEach phx_auto_triggerArray
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
    _x setVariable ["phx_auto_curOwner",3];
    _x setVariable ["phx_auto_lastOwner",3];
    _markerNameIterator = _markerNameIterator + 1;
} forEach phx_auto_triggerArray;

[phx_fnc_watchSector, _delay, [phx_auto_triggerArray, _delay]] call CBA_fnc_addPerFrameHandler;