/*
Initializes settings related to autoPvp and starts related logic loop.
The PFH finds a suitable location for a battle to take place and then makes calls to other functions.
*/
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
bc_auto_spotFound = false;

// Find starting locations for teams
[{
    params ["_args", "_handle"];
    
    bc_auto_centerLocation = call bc_fnc_chooseRandomCenter;
    
    bc_auto_teamStarts = [bc_auto_centerLocation, bc_auto_missionScale] call bc_fnc_findTeamStarts;
    if (count bc_auto_teamStarts isEqualTo 2) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        call bc_fnc_foundPositions;
        bc_auto_markerArray = [];
        
        bc_auto_flagpole = createVehicle ["Flag_White_F", bc_auto_centerLocation, [], 0, "NONE"];
        
        // DEBUG - Place markers at all 3 points
        {
            _markerName = format ["markerName_%1",_forEachIndex];
            _markerstr = createMarker [_markerName, [_x select 0, _x select 1]];
            _markerstr setMarkerShape "ICON";
            _markerstr setMarkerType "hd_dot";
            // _markerstr setMarkerText str(_forEachIndex);
            
            bc_auto_markerArray pushBack _markerName;
            
            // player setPos _x;
        } forEach bc_auto_teamStarts + [bc_auto_centerLocation];
        
        // Create circle around AO
        _markerstr2 = createMarker ["bc_auto_AOMarker", bc_auto_centerLocation];
        _markerstr2 setMarkerShape "ELLIPSE";
        _markerstr2 setMarkerSize [bc_auto_missionScale+75,bc_auto_missionScale+75];
        _markerstr2 setMarkerBrush "Border";
        
        bc_auto_markerArray pushBack "bc_auto_AOMarker";
        
        // END DEBUG
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;