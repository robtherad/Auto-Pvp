if (!hasInterface) exitWith {};

// Make sure the sector control script has been running long enough
phx_show_captureUI = true;
bc_show_timeUI = false;
private _totalCapTime = ["bc_auto_sectorTime",25] call BIS_fnc_getParamValue;

bc_auto_westPointsPublic = 0;
bc_auto_eastPointsPublic = 0;

diag_log "AUTODEBUG PVP - SHOULD HAVE ADDED DISPLAY PFH!";
[{
    params ["_args","_handle"];
    _args params ["_totalCapTime"];
    private ["_mins", "_secs"];
    
    disableSerialization;
    
    if (phx_show_captureUI || {bc_show_timeUI}) then {
        // Figure out time left for both teams
        {       
            // diag_log format["pointsDisplay --",];
            _x params ["_stringVar", "_timeVar", "_teamVar"];
            // diag_log format["pointsDisplay -- _x:%1",_x];
            if (_timeVar <= (_totalCapTime*60)) then {
                private _mins = (_totalCapTime - floor(_timeVar/60)) -1;
                private _secs = 60-floor(_timeVar%60);
                // diag_log format["pointsDisplay -- mins:%1 -- secs:%2",_mins,_secs];
                if ((_secs < 10) || (_secs == 60)) then {
                    if (_secs == 60) then {
                        if (_secs == 60) then {
                            _secs = "00";
                            _mins = (_totalCapTime - floor(_timeVar/60));
                        };
                    } else {
                        _secs = "0" + str(60-floor(_timeVar%60));
                    };
                };
                // diag_log format["pointsDisplay -- mins:%1 -- secs:%2",_mins,_secs];
                private _string = format ["%1 Time to Capture: %2:%3",_teamVar,_mins,_secs];
                // diag_log format["pointsDisplay -- string:%1",_string];
                missionNamespace setVariable [_stringVar, _string];
                
            } else {
                private _mins = floor((_timeVar-(_totalCapTime*60))/60);
                private _secs = floor((_timeVar-(_totalCapTime*60))%60);
                if (_secs < 10) then {
                    if (_secs == 0) then {
                        _secs = "00";
                        _mins = floor((_timeVar-(_totalCapTime*60))/60);
                    };
                    _secs = "0" + str(floor((_timeVar-(_totalCapTime*60))%60));
                    
                    private _string = format ["(DONE) %1 Time to Capture: %2:%3",_teamVar,_mins,_secs];
                    missionNamespace setVariable [_stringVar, _string];
                };
            };
        } forEach [["bc_auto_westPointsString", bc_auto_westPointsPublic, "BLUFOR"], ["bc_auto_eastPointsString", bc_auto_eastPointsPublic, "OPFOR"]];
        
        // Create displays in bottom left
        ("bluRsc" call BIS_fnc_rscLayer) cutRsc ["redforStructText", "PLAIN"];
        ("redRsc" call BIS_fnc_rscLayer) cutRsc ["bluforStructText", "PLAIN"];
        
        // Update text in the displays to match the points markers
        private _display = uiNameSpace getVariable "redforStructText";
        private _setText = _display displayCtrl 1001;
        _setText ctrlSetStructuredText (parseText format ["%1",bc_auto_eastPointsString]);
                
        private _display2 = uiNameSpace getVariable "bluforStructText";
        private _setText2 = _display2 displayCtrl 1002;
        _setText2 ctrlSetStructuredText (parseText format ["%1",bc_auto_westPointsString]);
    } else {
        ("bluRsc" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
        ("redRsc" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
    };
}, 1, [_totalCapTime]] call CBA_fnc_addPerFrameHandler;