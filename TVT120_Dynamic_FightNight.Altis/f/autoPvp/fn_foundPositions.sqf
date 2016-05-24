/*
Activates other functions that need to happen after the battlefield has been decided.
*/

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
phx_auto_foundPositions = true;
publicVariable "phx_auto_teamStarts"; // An array with sub arrays containing the X, Y, and Z coordinates of both team's starting positions.
publicVariable "phx_auto_centerLocation"; // An array containing the X, Y, and Z coordinates of the central point on the battlefield.
publicVariable "phx_auto_foundPositions"; // A boolean variable that clients running the placement script will be waiting for.