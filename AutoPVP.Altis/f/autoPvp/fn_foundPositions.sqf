
// bc_auto_centerLocation; // The center of the AO - The Sector's location

// bc_auto_teamStarts; // The center of each team's starting location


/*

- Create sector and place a flag pole in the center?
- Move teams to their starting positions
*/

call bc_fnc_createSector;

publicVariable "bc_auto_teamStarts"; // The randomstart script will be waiting for this the be defined. That script will handle moving all the players to the correct positions.