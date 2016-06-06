params ["_args", "_handle"];
_args params ["_triggerList", "_delay"];

private _triggerCount = count _triggerList;
private _markerNameIterator = 0;
{ // forEach _triggerList

    // Get owner of the cap from the last time it was checked
    private _sidePastOwned = _x getVariable "phx_auto_curOwner";
    private _sideLastOwned = _x getVariable "phx_auto_lastOwner";

    // Get marker names
    private _textMarkerName = str(_markerNameIterator) + "_phxAutoMarkText";
    private _bgMarkerName = str(_markerNameIterator) + "_phxAutoMark";
        
    private _westCount = {(alive _x) && {side group _x isEqualTo west}} count list _x;
    private _eastCount = {(alive _x) && {side group _x isEqualTo east}} count list _x;
    private _sideCurOwned = 4;

    // Western Controlled - 0
    if (_westCount > _eastCount) then {
        _sideCurOwned = 0;
        if (_sideCurOwned isEqualTo _sidePastOwned) then {
            phx_auto_westPoints = phx_auto_westPoints+ (1*_delay);
        } else {
            _textMarkerName setMarkerText (triggerText _x + " - BLUFOR Controlled");
            _bgMarkerName setMarkerColor "ColorBLUFOR";
            phx_auto_flagPole setFlagTexture "\ca\ca_e\data\flag_blufor_co.paa";
            _x setVariable ["phx_auto_lastOwner",_sideCurOwned, true];
        };
    };

    // Eastern Controlled - 1
    if (_eastCount > _westCount) then {
        _sideCurOwned = 1;
        if (_sideCurOwned isEqualTo _sidePastOwned) then {
            phx_auto_eastPoints = phx_auto_eastPoints+ (1*_delay);
        } else {
            _textMarkerName setMarkerText (triggerText _x + " - OPFOR Controlled");
            _bgMarkerName setMarkerColor "ColorOPFOR";
            phx_auto_flagPole setFlagTexture "\ca\ca_e\data\flag_opfor_co.paa";
            _x setVariable ["phx_auto_lastOwner",_sideCurOwned, true];
        };
    };

    // Contested Objective - 2
    if ((_westCount isEqualTo _eastCount) && {_westCount != 0}) then {
        _sideCurOwned = 2;
        _textMarkerName setMarkerText (triggerText _x + " - CONTESTED");
        _bgMarkerName setMarkerColor "ColorBlack";
        phx_auto_flagPole setFlagTexture "\ca\ca_e\data\flag_white_co.paa";
        _x setVariable ["phx_auto_lastOwner",_sideCurOwned, true];
    };

    // Neutral Objective - 3
    if ((_westCount isEqualTo _eastCount) && {_westCount isEqualTo 0}) then {
        _sideCurOwned = 3;
        // For objectives that a side controls but no longer occupies
        if (_sideLastOwned isEqualTo 0) then {
            phx_auto_westPoints = phx_auto_westPoints+ (1*_delay);
        };
        if (_sideLastOwned isEqualTo 1) then {
            phx_auto_eastPoints = phx_auto_eastPoints+ (1*_delay);
        };
    };
    
    // Set current owner
    _x setVariable ["phx_auto_curOwner",_sideCurOwned];

    // Sector has changed sides
    if ((_sideCurOwned != _sideLastOwned) && {_sideCurOwned != 3}) then {
        private _textString = "----";
        switch (_sideCurOwned) do {
            case 0: { _textString = format["BLUFOR have taken control of %1.",triggerText _x]; };
            case 1: { _textString = format["OPFOR have taken control of %1.",triggerText _x]; };
            case 2: { _textString = format["%1 is now contested.",triggerText _x]; };
        };
        [_textString] remoteExecCall ["phx_fnc_titleTextSector", 0];
    };
    // Iterator for marker names
    _markerNameIterator = _markerNameIterator + 1;
} forEach _triggerList;

// Update points for clients
if (phx_auto_westPoints != phx_auto_westPointsPublic) then {
    phx_auto_westPointsPublic = phx_auto_westPoints;
    publicVariable "phx_auto_westPointsPublic";
};
if (phx_auto_eastPoints != phx_auto_eastPointsPublic) then {
    phx_auto_eastPointsPublic = phx_auto_eastPoints;
    publicVariable "phx_auto_eastPointsPublic";
};

// Ending conditions
if (phx_auto_westPoints >= phx_auto_endPoints) then {
    private _textString = format ["The BLUFOR team has reached the required amount of points to win the mission."];
    [_textString] remoteExecCall ["phx_fnc_titleTextSector", 0];
    
    [_handle] call CBA_fnc_removePerFrameHandler;
};
if (phx_auto_eastPoints >= phx_auto_endPoints) then {
    private _textString = format ["The OPFOR team has reached the required amount of points to win the mission."];
    [_textString] remoteExecCall ["phx_fnc_titleTextSector", 0];
    
    [_handle] call CBA_fnc_removePerFrameHandler;
};