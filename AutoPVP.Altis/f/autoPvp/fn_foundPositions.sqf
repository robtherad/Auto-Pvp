
// bc_auto_centerLocation; // The center of the AO - The Sector's location

// bc_auto_teamStarts; // The center of each team's starting location


/*

- Create sector and place a flag pole in the center?
- Move teams to their starting positions
*/

call bc_fnc_createSector;

// Send info to clients for use in the placement scripts.
publicVariable "bc_auto_teamStarts";
publicVariable "bc_auto_centralLocation";
bc_auto_foundPositions = true;
publicVariable "bc_auto_foundPositions";