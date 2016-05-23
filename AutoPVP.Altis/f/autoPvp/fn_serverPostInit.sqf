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

// Get size of current map
private _worldIndex = _worldList find worldName;
if !(_worldIndex isEqualTo -1) then {
    bc_auto_worldSizeArray = _worldList select (_worldIndex + 1);
} else {
    bc_auto_worldSizeArray = [50000,50000]; // Unable to find correct world size.
    diag_log format ["PHX Auto PVP: (fn_serverPostInit) Unable to find world name in _worldList -- %1",worldName];
};

bc_auto_missionScale = ["bc_auto_AOSize",500] call BIS_fnc_getParamValue;
bc_auto_missionTime = ["bc_auto_timeLimit",45] call BIS_fnc_getParamValue;

// Find starting locations for teams
// TODO: Come up with a way to make sure the central location is accessable via land by both teams
[{
    params ["_args", "_handle"];
    
    bc_auto_centerLocation = call bc_fnc_chooseRandomCenter;
    bc_auto_teamStarts = [bc_auto_centerLocation, bc_auto_missionScale] call bc_fnc_findTeamStarts;
    
    /*
    // TODO: Figure out why this doesn't work. Game just hangs.
    // Break out of infinite loop and end mission if the script can't find a suitable play area in a reasonable amount of time.
    if (isNil "bc_auto_searchAttempts") then {bc_auto_searchAttempts = 0;};
    bc_auto_searchAttempts = bc_auto_searchAttempts + 1;
    diag_log format ["DEBUG Search Tries: %1",bc_auto_searchAttempts];
    if (bc_auto_searchAttempts >= 10) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        diag_log "PHX Auto PVP: (fn_serverPostInit) Unable to find suitable play area after 20 tries. Giving up.";
        "Lost" call BIS_fnc_endMissionServer;
    };
    */
        
    if (count bc_auto_teamStarts isEqualTo 2) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        bc_auto_searchAttempts = nil;
        
        call bc_fnc_foundPositions;
        bc_auto_markerArray = [];
        
        // Create Flag
        bc_auto_flagpole = createVehicle ["Flag_White_F", bc_auto_centerLocation, [], 0, "NONE"];
        bc_auto_flagpole allowDamage false;
        
        // Create AO Border
        bc_auto_centralMarker = createMarker ["bc_auto_AOMarker", bc_auto_centerLocation];
        bc_auto_centralMarker setMarkerShape "ELLIPSE";
        bc_auto_centralMarker setMarkerSize [bc_auto_missionScale + 50, bc_auto_missionScale + 50];
        bc_auto_centralMarker setMarkerBrush "Border";
        
        // Generate staging areas for both teams
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
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;