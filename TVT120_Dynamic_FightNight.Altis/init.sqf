//init.sqf - Executed when mission is started (before briefing screen)

// Adds mission boundary
[{
    params ["_args", "_handle"];
    
    private _missionStarted = missionNamespace getVariable ["phx_safeStartEnabled",true];
    if (!_missionStarted && {!isNil "phx_auto_centralMarker"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        [phx_fnc_core_playerBoundsCheck, 5, []] call CBA_fnc_addPerFrameHandler;
    };
}, 5, []] call CBA_fnc_addPerFrameHandler;

//Create briefing
[] execVM "briefing.sqf";

//Set the group IDs
[] call compile preprocessFileLineNumbers "f\setGroupID\f_setGroupIDs.sqf";

//Generate automatic ORBAT briefing page
[] execVM "f\briefing\f_orbatNotes.sqf";

//Call the safeStart
[] execVM "f\safeStart\f_safeStart.sqf";

//Call BC Template
[] execVM "f\bcInit.sqf";