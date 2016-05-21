private ["_color", "_text", "_teamStart", "_placeMark"];

if (side (group player) isEqualTo west) then {
    _color = "ColorBLUFOR";
    _text = "BLUFOR Starting Location";
    _teamStart = bc_auto_teamStarts select 0;
    _placeMark = "placeMark_Blue";
} else {
    _color = "ColorOPFOR";
    _text = "OPFOR Starting Location";
    _teamStart = bc_auto_teamStarts select 1;
    _placeMark = "placeMark_Red";
};

private _placeMarkPos = getMarkerPos _placeMark;

// Boundary marker for starting location
private _startMark = createMarkerLocal ["bc_rs_startZone",_teamStart];
_startMark setMarkerShapeLocal "ELLIPSE";
_startMark setMarkerSizeLocal [50, 50];
_startMark setMarkerBrushLocal "SolidBorder";
_startMark setMarkerColorLocal _color;

// Text marker for starting location
private _startMarkTwo = createMarkerLocal ["bc_rs_startZoneTwo",_teamStart];
_startMarkTwo setMarkerShapeLocal "ICON";
_startMarkTwo setMarkerColorLocal "ColorBlack";
_startMarkTwo setMarkerTypeLocal "hd_dot";
_startMarkTwo setMarkerTextLocal _text;

// Find player distance and direction to the placement marker.
private _dis = player distance2D _placeMarkPos;
private _dir = ((player getDir _placeMarkPos) + (_teamStart getDir bc_auto_centerLocation)) - 180;

// Returns a position that is a specified distance and compass direction from the passed position or object.
private _newPos = _teamStart getPos [_dis, _dir];

// Move player
player setPos [(_newPos select 0), (_newPos select 1)];
player setDir (_teamStart getDir bc_auto_centerLocation);
    
    
// Add a PFH that will pop up a warning for the player
// TODO: Add blinding mechanic here? - cutText ["","BLACK OUT",1,false];
[{
    params ["_args", "_handle"];
    
    if (time > 0) then {
        titleText ["Your team has been started in a location unknown to the enemy.\n\nDO NOT fire your weapon during safe start or the enemy will know where you are.","PLAIN DOWN", 1.5];
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        [{
            params ["_args", "_handle"];
            
            // "bc_auto_mapBlackOut" cutText ["","BLACK FADED",1,false];
            private _safeStart = missionNamespace getVariable ["bc_safeStartEnabled",false];
            if (_safeStart) then {
                "bc_auto_mapBlackOut" cutText ["","PLAIN DOWN",0.1,false];
            };
        }, 2, []] call CBA_fnc_addPerFrameHandler;
    };
}, 2, []] call CBA_fnc_addPerFrameHandler;
