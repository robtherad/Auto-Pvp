/*
Activates other functions that need to happen after the battlefield has been decided.
*/

// TODO: Add in a way for players to see current points. Also make points scale with the mission size/time. Maybe add capture point to spectator. Also change flag color with sector owner.
// Adds a PFH that will handle sector creation.
[{
    params ["_args","_handle"];
    
    if (!isNil "bc_auto_centralTrigger") then {
        bc_auto_centralTrigger setPos bc_auto_centerLocation; // Move pre-placed trigger to correct position
        [_handle] call CBA_fnc_removePerFrameHandler;
        call bc_fnc_createSector;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;

// Send info to clients for use in the placement scripts.
// TODO: Implement system that teleports players into their start zone, with their squads, only after the mission starts. Before that they will be able to move around a staging area and plan/discuss/etc.
bc_auto_foundPositions = true;
publicVariable "bc_auto_teamStarts"; // An array with sub arrays containing the X, Y, and Z coordinates of both team's starting positions.
publicVariable "bc_auto_centralLocation"; // An array containing the X, Y, and Z coordinates of the central point on the battlefield.
publicVariable "bc_auto_foundPositions"; // A boolean variable that clients running the placement script will be waiting for.

// TODO: Add boundary creation here. Must wait until after safestart to activate the boundaries.