params ["_args", "_handle"];

// Check if player is out of bounds - Requires a trigger named 'phx_missionAreaTrig' to exist
_playerInBounds = player inArea phx_coverMapMarker;
if (isNil "phx_playerWarnedCount") then {phx_playerWarnedCount = 0};
if (!_playerInBounds && {isNil "phx_isSpectator"}) then {
    phx_playerWarnedCount = phx_playerWarnedCount + 1;
    titleText ["WARNING!\n\nYou are outside of the mission area. Return immediately or YOU WILL BE KILLED!","PLAIN"];
    // Give player 5 iterations to get back into the playable area
    if (phx_playerWarnedCount > 5) then {
        player setDamage 1;
        systemChat "You were killed for being out of bounds for too long.";
    };
} else {
    // Reset player warning count since he's back in bounds
    if (phx_playerWarnedCount > 0) then {
        titleText ["","PLAIN DOWN",0.1];
        phx_playerWarnedCount = 0;
    };
    // Player is a spectator, exit
    if (!isNil "phx_isSpectator") then {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
};