/*
Activates other functions that need to happen after the battlefield has been decided.
*/

// Adds a PFH that will handle sector creation.
[{
    params ["_args","_handle"];
    
    if (!isNil "bc_auto_centralTrigger") then {
        bc_auto_centralTrigger setPos bc_auto_centerLocation; // Move pre-placed trigger to correct position
        [_handle] call CBA_fnc_removePerFrameHandler;
        call bc_fnc_createSector;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

// Send misc info
publicVariable "bc_auto_flagpole";
publicVariable "bc_auto_centralMarker";

// Send pre-start location information
publicVariable "bc_auto_westPreStart";
publicVariable "bc_auto_eastPreStart";
publicVariable "bc_auto_preStartLocationsFound";

// Send info about starting locations
bc_auto_foundPositions = true;
publicVariable "bc_auto_teamStarts"; // An array with sub arrays containing the X, Y, and Z coordinates of both team's starting positions.
publicVariable "bc_auto_centerLocation"; // An array containing the X, Y, and Z coordinates of the central point on the battlefield.
publicVariable "bc_auto_foundPositions"; // A boolean variable that clients running the placement script will be waiting for.
