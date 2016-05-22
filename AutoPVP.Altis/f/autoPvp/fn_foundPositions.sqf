/*
Activates other functions that need to happen after the battlefield has been decided.
*/


call bc_fnc_createSector; // Creates a sector at the center of the battlefield

// Send info to clients for use in the placement scripts.
bc_auto_foundPositions = true;
publicVariable "bc_auto_teamStarts"; // An array with sub arrays containing the X, Y, and Z coordinates of both team's starting positions.
publicVariable "bc_auto_centralLocation"; // An array containing the X, Y, and Z coordinates of the central point on the battlefield.
publicVariable "bc_auto_foundPositions"; // A boolean variable that clients running the placement script will be waiting for.