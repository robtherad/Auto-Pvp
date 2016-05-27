/*
Activates other functions that need to happen after the battlefield has been decided.
*/
if (!isServer) exitWith {};

// Adds a PFH that will handle sector creation.
[{
    params ["_args","_handle"];
    
    if (!isNil "phx_auto_centralTrigger") then {
        phx_auto_centralTrigger setPos phx_auto_centerLocation; // Move pre-placed trigger to correct position
        [_handle] call CBA_fnc_removePerFrameHandler;
        call phx_fnc_createSector;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

// Send misc info
publicVariable "phx_auto_flagpole";

// Send pre-start location information
publicVariable "phx_auto_westPreStart";
publicVariable "phx_auto_eastPreStart";
publicVariable "phx_auto_preStartLocationsFound";

// Send info about starting locations
publicVariable "phx_auto_teamStarts"; // An array with sub arrays containing the X, Y, and Z coordinates of both team's starting positions.
publicVariable "phx_auto_centerLocation"; // An array containing the X, Y, and Z coordinates of the central point on the battlefield.

// These four lines must go last for the admin reset ability to work
phx_auto_foundPositions = true;
publicVariable "phx_auto_foundPositions"; // A boolean variable that clients running the placement script will be waiting for.
phx_auto_createdMission = true; // Used to let the server know that everything has already been set up. Can't use foundPositions because sometimes the server is a client and foundPositions gets reset on clients.
phx_auto_currentlyRunning = nil; // Makes sure serverPostInit doesn't run again while it's still in use.
phx_auto_useOldCoordinates = nil; // Reset the variable that makes serverPostInit use the old stuff

// Add a PFH that waits for mission start to save the location variables to the server's profileNamespace
[{
    params ["_args", "_handle"];
    
    if (getClientStateNumber isEqualTo 10) then {
        [_handle] call CBA_fnc_removePerFrameHandler;

        profileNamespace setVariable [format["phx_auto_centerLocation_saved_%1",worldName], phx_auto_centerLocation];
        profileNamespace setVariable [format["phx_auto_teamStarts_saved_%1",worldName], phx_auto_teamStarts];
        profileNamespace setVariable [format["phx_auto_westPreStart_saved_%1",worldName], phx_auto_westPreStart];
        profileNamespace setVariable [format["phx_auto_eastPreStart_saved_%1",worldName], phx_auto_eastPreStart];
        
        saveProfileNamespace;
    };
}, 5, []] call CBA_fnc_addPerFrameHandler;
