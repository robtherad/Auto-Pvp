/*
Waits until the required variables are recieved from the server and then places the player in the correct spot.

Runs on clients.
*/
if (!hasInterface) exitWith {};

[{
    params ["_args", "_handle"];
    
    if ((side group player) isEqualTo sideLogic && {!isNil "phx_auto_foundPositions"} && {!isNil "phx_auto_preStartLocationsFound"} && {!isNil "phx_auto_teamStarts"} && {!isNil "phx_auto_centerLocation"} && {!isNil "phx_auto_westPreStart"} && {!isNil "phx_auto_eastPreStart"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        
        // Reset this variable so that the server is required to reinitialize it when changing battlefields.
        phx_auto_foundPositions = nil;
        
        if (!isNil "phx_placeMoveRunning") exitWith {};
        phx_placeMoveRunning = true;
        
        if (!isNil "phx_rs_markerArray") then {
            {
                deleteMarker _x;
            } forEach phx_rs_markerArray;
            phx_rs_markerArray = [];
        } else {
            phx_rs_markerArray = [];
        };
        
        // Prestarts
        _marker = createMarkerLocal ["phx_rs_spectWestMark",phx_auto_teamStarts select 0];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerTypeLocal "hd_dot";
        _marker setMarkerTextLocal "BLUFOR Start";
        phx_rs_markerArray pushBack _marker;

        _marker = createMarkerLocal ["phx_rs_spectEastMark",phx_auto_teamStarts select 1];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerTypeLocal "hd_dot";
        _marker setMarkerTextLocal "OPFOR Start";
        phx_rs_markerArray pushBack _marker;
        
         // Regular starts
        _marker = createMarkerLocal ["phx_rs_spectWestMark2",phx_auto_westPreStart];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerTypeLocal "hd_dot";
        _marker setMarkerTextLocal "BLUFOR Staging Area";
        phx_rs_markerArray pushBack _marker;
        
        _marker = createMarkerLocal ["phx_rs_spectEastMark2",phx_auto_eastPreStart];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerTypeLocal "hd_dot";
        _marker setMarkerTextLocal "OPFOR Staging Area";
        phx_rs_markerArray pushBack _marker;
        
        // Finished Moving
        phx_placeMoveRunning = nil;
        
    };
    
    if (!((side group player) isEqualTo sideLogic) && {!isNil "phx_auto_preStartLocationsFound"} && {!isNil "phx_auto_teamStarts"} && {!isNil "phx_auto_centerLocation"} && {!isNil "phx_auto_westPreStart"} && {!isNil "phx_auto_eastPreStart"} && {!isNil "phx_auto_foundPositions"}) then {
        [_handle] call CBA_fnc_removePerFrameHandler;

        // Reset this variable so that the server is required to reinitialize it when changing battlefields.
        phx_auto_foundPositions = nil;
        
        // Make sure variables are in the correct scope
        private ["_color", "_text", "_otherText", "_preText", "_teamPreStart", "_placeMark"];

        if (!isNil "phx_placeMoveRunning") exitWith {};
        phx_placeMoveRunning = true;

        // Figure out what side player is on
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

        // Remove markers if they have already been placed
        if (!isNil "phx_rs_markerArray") then {
            {
                deleteMarker _x;
            } forEach phx_rs_markerArray;
            phx_rs_markerArray = [];
        } else {
            phx_rs_markerArray = [];
        };

        // Pre-Start Location Markers
            // Boundary marker for starting location
            private _marker = createMarkerLocal ["phx_rs_preStartZone",_teamPreStart];
            _marker setMarkerShapeLocal "ELLIPSE";
            _marker setMarkerSizeLocal [50, 50];
            _marker setMarkerBrushLocal "SolidBorder";
            _marker setMarkerColorLocal _color;
            phx_rs_markerArray pushBack _marker;

            // Text marker for starting location
            _marker = createMarkerLocal ["phx_rs_preStartZoneTwo",_teamPreStart];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerColorLocal "ColorBlack";
            _marker setMarkerTypeLocal "hd_dot";
            _marker setMarkerTextLocal _preText;
            phx_rs_markerArray pushBack _marker;

            
        // Starting Location Markers
            // Own Team's Marker
            _marker = createMarkerLocal ["phx_rs_startZoneFriendly",phx_auto_ownTeamStart];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerColorLocal "ColorBlack";
            _marker setMarkerTypeLocal "hd_dot";
            _marker setMarkerTextLocal _text;
            phx_rs_markerArray pushBack _marker;

            // Create marker for other team's Starting Location
            private _showMarkerInt = ["phx_auto_showOtherTeamStart",0] call BIS_fnc_getParamValue;
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
                private _marker = createMarkerLocal ["phx_rs_startZoneEnemy",phx_auto_otherTeamStart];
                _marker setMarkerShapeLocal "ICON";
                _marker setMarkerColorLocal "ColorBlack";
                _marker setMarkerTypeLocal "hd_dot";
                _marker setMarkerTextLocal _otherText;
                phx_rs_markerArray pushBack _marker;
            };
            
        // Move player to Staging Area - Player gets moved to real starting area via fn_safety (f\safestart\f_fn_safety) being called with the false parameter
            // Find player distance and direction to the placement marker.
            if (isNil "phx_rs_distance") then {
                phx_rs_distance = player distance2D _placeMarkPos;
                phx_rs_direction = ((player getDir _placeMarkPos) + (phx_auto_ownTeamStart getDir phx_auto_centerLocation)) - 180;
            };
            // Returns a position that is a specified distance and compass direction from the passed position or object.
            private _newPos = _teamPreStart getPos [phx_rs_distance, phx_rs_direction];

            // Move player
            player setPos [(_newPos select 0), (_newPos select 1)];
            player setDir (_teamPreStart getDir phx_auto_centerLocation);
            
        // Finished Moving
        phx_placeMoveRunning = nil;

        if (!isNil "phx_auto_clientMovedHintAdded") then {
            phx_auto_clientMovedHintAdded = true;
            // Add a PFH that will pop up a warning for the player
            [{
                params ["_args", "_handle"];
                if (CBA_missionTime > 0 && {phx_safeStartEnabled}) then {
                    titleText [
                    "Your team is currently located at it's staging area which is marked on the map.
                    \nAfter safestart is over you will be automatically teleported to your team's starting area within the AO.
                    \nYou will arrive there in the same formation that you arrived in when you got here."
                    , "PLAIN DOWN", 2];
                    [_handle] call CBA_fnc_removePerFrameHandler;
                };
            }, 2, []] call CBA_fnc_addPerFrameHandler;
        };
        
    };
}, 0, []] call CBA_fnc_addPerFrameHandler;