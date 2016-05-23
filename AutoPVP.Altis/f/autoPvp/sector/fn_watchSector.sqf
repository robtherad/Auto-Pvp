params ["_args", "_handle"];
_args params ["_triggerList"];

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
            bc_auto_westPoints = bc_auto_westPoints + _triggerCount;
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
            bc_auto_eastPoints = bc_auto_eastPoints + _triggerCount;
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
            bc_auto_westPoints = bc_auto_westPoints + _triggerCount;
        };
        if (_sideLastOwned isEqualTo 1) then {
            bc_auto_eastPoints = bc_auto_eastPoints + _triggerCount;
        };
    };
    
    // Set current owner
    _x setVariable ["bc_auto_curOwner",_sideCurOwned];

    // Sector has changed sides
    if ((_sideCurOwned != _sideLastOwned) && {_sideCurOwned != 3}) then {
        // [[_sideCurOwned, _x],"scripts\sectors\client.sqf"] remoteExecCall ["BIS_fnc_execVM", 0];
    };
    // Iterator for marker names
    _markerNameIterator = _markerNameIterator + 1;
} forEach _triggerList;

// Ending conditions
if (bc_auto_westPoints >= bc_auto_endPoints) then {
    _currentState = 5;
    // [[_currentState,bc_auto_westPoints,bc_auto_eastPoints,bc_auto_endPoints],"scripts\sectors\client.sqf"] remoteExecCall ["BIS_fnc_execVM", 0];
    bc_auto_playing = false;
};
if (bc_auto_eastPoints >= bc_auto_endPoints) then {
    _currentState = 6;
    // [[_currentState,bc_auto_westPoints,bc_auto_eastPoints,bc_auto_endPoints],"scripts\sectors\client.sqf"] remoteExecCall ["BIS_fnc_execVM", 0];
    bc_auto_playing = false;
};