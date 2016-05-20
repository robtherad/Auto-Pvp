// Runs on server at postInit
if (!isServer) exitWith {};

private _worldList = [
    // "worldName, [worldXSize, worldYSize],
    "Altis", [30000,30000], 
    "Stratis", []
    
    // Don't forget to remove the comma after the last position array!
];

// Determine World Size
private _worldIndex = _worldList find worldName;
bc_auto_worldSizeArray = _worldList select (_worldIndex + 1);

// Determine Mission Scale (Border distance)
bc_auto_missionScale = 500;

// Find starting locations for teams
[{
    params ["_args", "_handle"];
    
    bc_auto_centerLocation = call bc_fnc_chooseRandomCenter;
    
    bc_auto_teamStarts = [bc_auto_centerLocation, bc_auto_missionScale] call bc_fnc_findTeamStarts;
    if (count bc_auto_teamStarts isEqualTo 2) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        private _forEachDebug = bc_auto_teamStarts;
        _forEachDebug pushBack bc_auto_centerLocation;
        
        // DEBUG - Place markers at all 3 points
        {
            _markerName = format ["markerName_%1",_forEachIndex];
            diag_log format["Auto Pvp DEBUG: %1",_x];
            _markerstr = createMarker [_markerName, [_x select 0, _x select 1]];
            _markerstr setMarkerShape "ICON";
            _markerstr setMarkerType "hd_dot";
            _markerstr setMarkerText str(_forEachIndex);
        } forEach _forEachDebug;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

// TODO: Come up with a way to black out player screens during safestart time but still let them view the map OR find an easy way to split teams up during the briefing screen