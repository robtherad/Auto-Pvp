if (!hasInterface) exitWith {};

[{
    params ["_args", "_handle"];
    
    if (!isNil "phx_auto_foundPositions" && {!isNil "phx_auto_preStartLocationsFound"} && {!isNil "phx_auto_teamStarts"} && {!isNil "phx_auto_centerLocation"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        call phx_fnc_placeMove;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;