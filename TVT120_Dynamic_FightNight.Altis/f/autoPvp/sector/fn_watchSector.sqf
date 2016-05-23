params ["_args", "_handle"];
_args params ["_triggerList", "_delay"];

private _triggerCount = count _triggerList;
private _markerNameIterator = 0;
{ // forEach _triggerList

    // Get owner of the cap from the last time it was checked
    private _sidePastOwned = _x getVariable "bc_auto_curOwner";
    private _sideLastOwned = _x getVariable "bc_auto_lastOwner";

    // Get marker names
    private _textMarkerName = str(_markerNameIterator) + "_BCAutoMarkText";
    private _bgMarkerName = str(_markerNameIterator) + "_BCAutoMark";
        
    private _westCount = {(alive _x) && {side group _x isEqualTo west}} count list _x;
    private _eastCount = {(alive _x) && {side group _x isEqualTo east}} count list _x;
    private _sideCurOwned = 4;

    // Western Controlled - 0
    if (_westCount > _eastCount) then {
        _sideCurOwned = 0;
        if (_sideCurOwned isEqualTo _sidePastOwned) then {
            bc_auto_westPoints = bc_auto_westPoints+ (1*_delay);
        } else {
            _textMarkerName setMarkerText (triggerText _x + " - BLUFOR Controlled");
            _bgMarkerName setMarkerColor "ColorBLUFOR";
            bc_auto_flagPole setFlagTexture "\ca\ca_e\data\flag_blufor_co.paa";
            _x setVariable ["bc_auto_lastOwner",_sideCurOwned];
        };
    };

    // Eastern Controlled - 1
    if (_eastCount > _westCount) then {
        _sideCurOwned = 1;
        if (_sideCurOwned isEqualTo _sidePastOwned) then {
            bc_auto_eastPoints = bc_auto_eastPoints+ (1*_delay);
        } else {
            _textMarkerName setMarkerText (triggerText _x + " - OPFOR Controlled");
            _bgMarkerName setMarkerColor "ColorOPFOR";
            bc_auto_flagPole setFlagTexture "\ca\ca_e\data\flag_opfor_co.paa";
            _x setVariable ["bc_auto_lastOwner",_sideCurOwned];
        };
    };

    // Contested Objective - 2
    if ((_westCount isEqualTo _eastCount) && {_westCount != 0}) then {
        _sideCurOwned = 2;
        _textMarkerName setMarkerText (triggerText _x + " - CONTESTED");
        _bgMarkerName setMarkerColor "ColorBlack";
        bc_auto_flagPole setFlagTexture "\ca\ca_e\data\flag_white_co.paa";
        _x setVariable ["bc_auto_lastOwner",_sideCurOwned];
    };

    // Neutral Objective - 3
    if ((_westCount isEqualTo _eastCount) && {_westCount isEqualTo 0}) then {
        _sideCurOwned = 3;
        // For objectives that a side controls but no longer occupies
        if (_sideLastOwned isEqualTo 0) then {
            bc_auto_westPoints = bc_auto_westPoints+ (1*_delay);
        };
        if (_sideLastOwned isEqualTo 1) then {
            bc_auto_eastPoints = bc_auto_eastPoints+ (1*_delay);
        };
    };
    
    // Set current owner
    _x setVariable ["bc_auto_curOwner",_sideCurOwned];

    // Sector has changed sides
    if ((_sideCurOwned != _sideLastOwned) && {_sideCurOwned != 3}) then {
        private _textString = "----";
        switch (_sideCurOwned) do {
            case 0: { _textString = format["BLUFOR have taken control of %1.",triggerText _x]; };
            case 1: { _textString = format["OPFOR have taken control of %1.",triggerText _x]; };
            case 2: { _textString = format["%1 is now contested.",triggerText _x]; };
        };
        [_textString] remoteExecCall ["bc_fnc_titleTextSector", 0];
    };
    // Iterator for marker names
    _markerNameIterator = _markerNameIterator + 1;
} forEach _triggerList;

// Update points for clients
if (bc_auto_westPoints != bc_auto_westPointsPublic) then {
    bc_auto_westPointsPublic = bc_auto_westPoints;
    publicVariable "bc_auto_westPointsPublic";
};
if (bc_auto_eastPoints != bc_auto_eastPointsPublic) then {
    bc_auto_eastPointsPublic = bc_auto_eastPoints;
    publicVariable "bc_auto_eastPointsPublic";
};

// Ending conditions
if (bc_auto_westPoints >= bc_auto_endPoints) then {
    private _textString = format ["The BLUFOR team has reached the required amount of points to win the mission."];
    [_textString] remoteExecCall ["bc_fnc_titleTextSector", 0];
    
    [_handle] call CBA_fnc_removePerFrameHandler;
};
if (bc_auto_eastPoints >= bc_auto_endPoints) then {
    private _textString = format ["The OPFOR team has reached the required amount of points to win the mission."];
    [_textString] remoteExecCall ["bc_fnc_titleTextSector", 0];
    
    [_handle] call CBA_fnc_removePerFrameHandler;
};