//init.sqf - Executed when mission is started (before briefing screen)

// Add a PFH loop that will wait until safestart has ended to activate the boundary script -OR- If safestart was disabled, moves the player to their starting location and then activates the boundary script.
private _safestartParam = ["f_param_mission_timer",10] call BIS_fnc_getParamValue;
if !(_safestartParam isEqualTo 0) then {
    [{
        params ["_args", "_handle"];
        
        private _missionStarted = missionNamespace getVariable ["phx_safeStartEnabled",true];
        if (!_missionStarted && {!isNil "phx_coverMapMarker"}) then {
            [_handle] call CBA_fnc_removePerFrameHandler;
            [phx_fnc_core_playerBoundsCheck, 5, []] call CBA_fnc_addPerFrameHandler;
        };
    }, 5, []] call CBA_fnc_addPerFrameHandler;
} else {
    [{
        params ["_args", "_handle"];
        
        if (!isNil "phx_auto_ownTeamStart" && {!isNil "phx_rs_direction"} && {!isNil "phx_rs_distance"} && {!isNil "phx_auto_centerLocation"}) then {
            [false] call f_fnc_safety;
        
            private _missionStarted = missionNamespace getVariable ["phx_safeStartEnabled",true];
            if (!_missionStarted && {!isNil "phx_coverMapMarker"}) then {
                [_handle] call CBA_fnc_removePerFrameHandler;
                [phx_fnc_core_playerBoundsCheck, 5, []] call CBA_fnc_addPerFrameHandler;
            };
        };
    }, 0, []] call CBA_fnc_addPerFrameHandler;
};

//Create briefing
[] execVM "briefing.sqf";

//Set the group IDs
[] call compile preprocessFileLineNumbers "f\setGroupID\f_setGroupIDs.sqf";

//Generate automatic ORBAT briefing page
[] execVM "f\briefing\f_orbatNotes.sqf";

//Call the safeStart
[] execVM "f\safeStart\f_safeStart.sqf";

//Call phx Template
[] execVM "f\phxInit.sqf";