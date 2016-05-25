// Adds a CBA PFH that waits until related variables are initialized before moving the player.
if (!hasInterface) exitWith {};
[{
    params ["_args", "_handle"];

    if (!isNil "phx_auto_foundPositions" && {!isNil "phx_auto_preStartLocationsFound"} && {!isNil "phx_auto_teamStarts"} && {!isNil "phx_auto_centerLocation"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;

        // Reset this variable so that the server is required to reinitialize it when changing battlefields.
        phx_auto_foundPositions = nil;
        
        call phx_fnc_placeMove;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;