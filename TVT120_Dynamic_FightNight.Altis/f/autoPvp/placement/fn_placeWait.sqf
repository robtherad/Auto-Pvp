if (!hasInterface) exitWith {};

[{
    params ["_args", "_handle"];
    
    if (!isNil "bc_auto_foundPositions" && {!isNil "bc_auto_preStartLocationsFound"} && {!isNil "bc_auto_teamStarts"} && {!isNil "bc_auto_centerLocation"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        call bc_fnc_placeMove;
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;