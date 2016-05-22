/*
Initializes settings related to autoPvp and starts related logic loop.
The PFH finds a suitable location for a battle to take place and then makes calls to other functions.
*/
if (!isServer) exitWith {};

private _worldList = [
    // TODO: Get world sizes for other maps.
    // "worldName, [worldXSize, worldYSize],
    "Altis", [30000,30000], 
    "Stratis", []
    
    // Don't forget to remove the comma after the last position array!
];

// Determine World Size
private _worldIndex = _worldList find worldName;
bc_auto_worldSizeArray = _worldList select (_worldIndex + 1);

// Determine Mission Scale (AO Borders)
// TODO: Write scaling function. 
// Should return the size of the mission boundary as a single number. Use the same variable, bc_auto_missionScale.
// Lower playercount = smaller play area, larger playercount = bigger play area
bc_auto_missionScale = 500;

// Find starting locations for teams
// TODO: Come up with a way to make sure the central location is accessable via land by both teams
[{
    params ["_args", "_handle"];
    
    bc_auto_centerLocation = call bc_fnc_chooseRandomCenter;
    
    bc_auto_teamStarts = [bc_auto_centerLocation, bc_auto_missionScale] call bc_fnc_findTeamStarts;
    if (count bc_auto_teamStarts isEqualTo 2) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        call bc_fnc_foundPositions;
        bc_auto_markerArray = [];
        
        bc_auto_flagpole = createVehicle ["Flag_White_F", bc_auto_centerLocation, [], 0, "NONE"];
        
        // Generate pre-start locations for both teams to 
        [{
            params ["_args", "_handle"];
            
            // Generate pre-start locations for teams
            if (isNil "bc_auto_westPreStart") then {
                bc_auto_westPreStart = call bc_fnc_chooseRandomCenter;
            };
            if (isNil "bc_auto_eastPreStart") then {
                bc_auto_eastPreStart = call bc_fnc_chooseRandomCenter;
            };
            
            // Make sure the locations aren't too close to each other or to the actual play area
            private _acceptableDistance = bc_auto_missionScale*2;
            if ( (bc_auto_westPreStart distance bc_auto_centerLocation) < _acceptableDistance ) then {
                bc_auto_westPreStart = nil;
            };
            if ( (bc_auto_eastPreStart distance bc_auto_centerLocation) < _acceptableDistance && {(bc_auto_eastPreStart distance bc_auto_centerLocation) < 750}) then {
                bc_auto_eastPreStart = nil;
            };
            
            // Check if both variables are complete
            if (!isNil "bc_auto_westPreStart" && {!isNil "bc_auto_eastPreStart"}) then {
                [_handle] call CBA_fnc_removePerFrameHandler;
                
                bc_auto_preStartLocationsFound = true;
            };
        }, 0, []] call CBA_fnc_addPerFrameHandler;
        /*
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
        */
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;