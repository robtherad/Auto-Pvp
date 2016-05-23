// F3 - Briefing
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================
// BRIEFING: ADMIN
// The following block of code executes only if the player is the current host
// it automatically includes a file which contains the appropriate briefing data.

if (serverCommandAvailable "#kick") then {
    #include "f\briefing\f_briefing_admin.sqf"
};

// ====================================================================================
// Custom mission briefing

player createDiarySubject ["bc_autoDiary", "Auto PVP Info"];
player createDiaryRecord ["bc_autoDiary", ["Scenario", "
 If safestart is enabled your team will start in it's staging area which is marked on the map. Feel free to use the space to formulate a plan and organize yourselves.<br/>
 <br/>
 Once safestart has ended, your team will be teleported to it's starting zone within the mission area. From there you must eliminate the other team or capture and hold the sector in the center of the mission area until your team is victorious."]];
player createDiaryRecord ["bc_autoDiary", ["Sector", "
 To find out exactly how long you need to hold the capture point to win please check the 'Log' tab on the left and then on the 'Parameters' sub-tab find the parameter that says 'Cumulative Time to Capture Sector'. The time listed there is how long your team will need to control the sector in order to win.<br/>
 <br/>
 To win via sector capture, a team does not need to control the sector for a continuous amount of time equal to the mission parameter. A team can lose control of the sector and then regain it and continue to accumulate points from where they left off when they lost control of the sector.<br/>
 <br/>
 Ownership of the sector is given to the most recent team to have the highest number of players within it's bounds. If only one team goes to the sector and takes control of it, then leaves, the sector will still be under their ownership and thus will continue to generate points for that team.<br/>
 <br/>
 If the sector contains an equal number of players from both teams then the sector's status will change to CONTESTED. In this state, neither team will gain points from the sector. The sector will stay this way until one team achieves numerical superiority within the sector.
"]];