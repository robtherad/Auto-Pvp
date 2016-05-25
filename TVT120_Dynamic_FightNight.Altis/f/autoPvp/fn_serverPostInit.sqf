/*
Initializes settings related to autoPvp and starts related logic loop.
The PFH finds a suitable location for a battle to take place and then makes calls to other functions.
*/
if (!isServer) exitWith {};

if (!isNil "phx_auto_currentlyRunning") exitWith {};
phx_auto_currentlyRunning = true;

private _worldList = [
    // TODO: Get world sizes for other maps.
    // "worldName, [worldXSize, worldYSize],
    "Altis", [30000,30000], 
    "Stratis", []
    
    // Don't forget to remove the comma after the last position array!
]; // Don't delete!

// Get size of current map
private _worldIndex = _worldList find worldName;
if !(_worldIndex isEqualTo -1) then {
    phx_auto_worldSizeArray = _worldList select (_worldIndex + 1);
} else {
    phx_auto_worldSizeArray = [30000,30000]; // Unable to find correct world size.
    diag_log format ["PHX Auto PVP: (fn_serverPostInit) Unable to find world name in _worldList -- %1",worldName];
};

// Import mission params
phx_auto_missionScale = ["phx_auto_AOSize",500] call BIS_fnc_getParamValue;
phx_auto_missionTime = ["phx_auto_timeLimit",45] call BIS_fnc_getParamValue;

// RESET - Triggers placeWait PFH on clients
if (!isNil "phx_auto_createdMission") then {
    [] remoteExecCall ["phx_fnc_placeWait",0];
};

// Find starting locations for teams
// TODO: Come up with a way to make sure the central location is accessable via land by both teams
[{
    params ["_args", "_handle"];
    
    phx_auto_centerLocation = call phx_fnc_chooseRandomCenter;
    phx_auto_teamStarts = [phx_auto_centerLocation, phx_auto_missionScale] call phx_fnc_findTeamStarts;
    
    /*
    // TODO: Figure out why this doesn't work. Game just hangs.
    // Break out of infinite loop and end mission if the script can't find a suitable play area in a reasonable amount of time.
    if (isNil "phx_auto_searchAttempts") then {phx_auto_searchAttempts = 0;};
    phx_auto_searchAttempts = phx_auto_searchAttempts + 1;
    diag_log format ["DEBUG Search Tries: %1",phx_auto_searchAttempts];
    if (phx_auto_searchAttempts >= 10) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        diag_log "PHX Auto PVP: (fn_serverPostInit) Unable to find suitable play area after 20 tries. Giving up.";
        "Lost" call BIS_fnc_endMissionServer;
    };
    */
        
    if (count phx_auto_teamStarts isEqualTo 2) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        phx_auto_searchAttempts = nil;
        
        phx_auto_markerArray = [];
        
        // Create Flag
        phx_auto_flagpole = createVehicle ["Flag_White_F", phx_auto_centerLocation, [], 0, "NONE"];
        phx_auto_flagpole allowDamage false;
        
        // Make sure these variables are nil so they can be searched for again in the following CBA PFH.
        phx_auto_westPreStart = nil;
        phx_auto_eastPreStart = nil;
        
        // Generate staging areas for both teams
        [{
            params ["_args", "_handle"];
            
            // Generate pre-start locations for teams
            if (isNil "phx_auto_westPreStart") then {
                phx_auto_westPreStart = call phx_fnc_chooseRandomCenter;
            };
            if (isNil "phx_auto_eastPreStart") then {
                phx_auto_eastPreStart = call phx_fnc_chooseRandomCenter;
            };
            
            // Make sure the locations aren't too close to each other or to the actual play area
            private _acceptableDistance = phx_auto_missionScale*2;
            if ( (phx_auto_westPreStart distance phx_auto_centerLocation) < _acceptableDistance ) then {
                phx_auto_westPreStart = nil;
            };
            if ( (phx_auto_eastPreStart distance phx_auto_centerLocation) < _acceptableDistance && {(phx_auto_eastPreStart distance phx_auto_centerLocation) < 750}) then {
                phx_auto_eastPreStart = nil;
            };
            
            // Check if both variables are complete
            if (!isNil "phx_auto_westPreStart" && {!isNil "phx_auto_eastPreStart"}) then {
                [_handle] call CBA_fnc_removePerFrameHandler;
                
                phx_auto_preStartLocationsFound = true;
                
                call phx_fnc_coverMap;
                call phx_fnc_foundPositions;
            };
            
            
        }, 0, []] call CBA_fnc_addPerFrameHandler;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;