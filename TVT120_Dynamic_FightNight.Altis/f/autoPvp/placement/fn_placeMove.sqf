private ["_color", "_text", "_otherText", "_preText", "_teamPreStart", "_placeMark"];

if (side (group player) isEqualTo west) then {
    _color = "ColorBLUFOR";
    _text = "BLUFOR Start";
    _otherText = "OPFOR Start";
    _preText = "BLUFOR Staging Area";
    phx_auto_otherTeamStart = phx_auto_teamStarts select 1;
    phx_auto_ownTeamStart = phx_auto_teamStarts select 0;
    _teamPreStart = phx_auto_westPreStart;
    _placeMark = "placeMark_Blue";
} else {
    _color = "ColorOPFOR";
    _text = "OPFOR Start";
    _otherText = "BLUFOR Start";
    _preText = "OPFOR Staging Area";
    phx_auto_otherTeamStart = phx_auto_teamStarts select 0;
    phx_auto_ownTeamStart = phx_auto_teamStarts select 1;
    _teamPreStart = phx_auto_eastPreStart;
    _placeMark = "placeMark_Red";
};
private _placeMarkPos = getMarkerPos _placeMark;


// Pre-Start Location Markers
    // Boundary marker for starting location
    private _startMark = createMarkerLocal ["phx_rs_preStartZone",_teamPreStart];
    _startMark setMarkerShapeLocal "ELLIPSE";
    _startMark setMarkerSizeLocal [50, 50];
    _startMark setMarkerBrushLocal "SolidBorder";
    _startMark setMarkerColorLocal _color;

    // Text marker for starting location
    private _startMarkTwo = createMarkerLocal ["phx_rs_preStartZoneTwo",_teamPreStart];
    _startMarkTwo setMarkerShapeLocal "ICON";
    _startMarkTwo setMarkerColorLocal "ColorBlack";
    _startMarkTwo setMarkerTypeLocal "hd_dot";
    _startMarkTwo setMarkerTextLocal _preText;

    
// Starting Location Markers
    // Own Team's Marker
    private _startMarkTwo = createMarkerLocal ["phx_rs_startZoneFriendly",phx_auto_ownTeamStart];
    _startMarkTwo setMarkerShapeLocal "ICON";
    _startMarkTwo setMarkerColorLocal "ColorBlack";
    _startMarkTwo setMarkerTypeLocal "hd_dot";
    _startMarkTwo setMarkerTextLocal _text;

    // Create marker for other team's Starting Location
    private _showMarkerInt = ["phx_showOtherTeamStart",0] call BIS_fnc_getParamValue;
    private _showMarkerBool = false;
    
    if (_showMarkerInt isEqualTo 1 && {(side group player) isEqualTo west}) then {
        _showMarkerBool = true;
    };
    if (_showMarkerInt isEqualTo 2 && {(side group player) isEqualTo east}) then {
        _showMarkerBool = true;
    };
    if (_showMarkerInt isEqualTo 3) then {
        _showMarkerBool = true;
    };
    
    if (_showMarkerBool) then {
        private _startMarkTwo = createMarkerLocal ["phx_rs_startZoneEnemy",phx_auto_otherTeamStart];
        _startMarkTwo setMarkerShapeLocal "ICON";
        _startMarkTwo setMarkerColorLocal "ColorBlack";
        _startMarkTwo setMarkerTypeLocal "hd_dot";
        _startMarkTwo setMarkerTextLocal _otherText;
    };
    
    
// Move player to Staging Area - Player gets moved to real starting area via fn_safety (f\safestart\f_fn_safety) being called with the false parameter
    // Find player distance and direction to the placement marker.
    phx_rs_distance = player distance2D _placeMarkPos;
    phx_rs_direction = ((player getDir _placeMarkPos) + (phx_auto_ownTeamStart getDir phx_auto_centerLocation)) - 180;

    // Returns a position that is a specified distance and compass direction from the passed position or object.
    private _newPos = _teamPreStart getPos [phx_rs_distance, phx_rs_direction];

    // Move player
    player setPos [(_newPos select 0), (_newPos select 1)];
    player setDir (_teamPreStart getDir phx_auto_centerLocation);

    
// Add a PFH that will pop up a warning for the player
[{
    params ["_args", "_handle"];
    if (time > 0 && {phx_safeStartEnabled}) then {
        titleText [
        "Your team is currently located at it's staging area which is marked on the map.
        \nAfter safestart is over you will be automatically teleported to your team's starting area within the AO.
        \nYou will arrive there in the same formation that you arrived in when you got here."
        , "PLAIN DOWN", 2];
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
}, 2, []] call CBA_fnc_addPerFrameHandler;
