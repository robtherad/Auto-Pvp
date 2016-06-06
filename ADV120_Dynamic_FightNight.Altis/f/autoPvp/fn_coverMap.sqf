/*
Creates a square around the AO and grays out the area around it. Based on the BIS module.

Runs on server.
*/
if (!isServer) exitWith {};

if (!isNil "phx_coveredMap") then {
    {
        deleteMarker _x;
    } forEach ["bis_fnc_moduleCoverMap_border", "bis_fnc_moduleCoverMap_0", "bis_fnc_moduleCoverMap_90", "bis_fnc_moduleCoverMap_180", "bis_fnc_moduleCoverMap_270"];
};

// Initialize Variables
private _pos = phx_auto_centerLocation;
private _posX = phx_auto_centerLocation select 0;
private _posY = phx_auto_centerLocation select 1;
private _sizeX = phx_auto_missionScale + 50;
private _sizeY = phx_auto_missionScale + 50;
private _dir = 0;
private _sizeOut = 100000;

// Create mission boundary marker
private _marker = "bis_fnc_moduleCoverMap_border";
phx_coverMapMarker = createmarker [_marker,_pos];
publicVariable "phx_coverMapMarker";
_marker setmarkerpos _pos;
_marker setmarkersize [_sizeX,_sizeY];
_marker setmarkerdir _dir;
_marker setmarkershape "rectangle";
_marker setmarkerbrush "border";
_marker setmarkercolor "colorblack";

// Create outer markers
for "_i" from 0 to 270 step 90 do {
    private _size1 = [_sizeX,_sizeY] select (abs cos _i);
    private _size2 = [_sizeX,_sizeY] select (abs sin _i);
    private _sizeMarker = [_size2,_sizeOut] select (abs sin _i);
    private _dirTemp = _dir + _i;
    private _markerPos = [
        _posX + (sin _dirTemp * _sizeOut),
        _posY + (cos _dirTemp * _sizeOut)
    ];
    
    // Create covering marker
    private _marker = format ["bis_fnc_moduleCoverMap_%1",_i];
    createmarker [_marker,_markerPos];
    _marker setmarkerpos _markerPos;
    _marker setmarkersize [_sizeMarker,_sizeOut - _size1];
    _marker setmarkerdir _dirTemp;
    _marker setmarkershape "rectangle";
    _marker setmarkerbrush "Solid";
    _marker setmarkercolor "colorBlack";
};

phx_coveredMap = true;

// Update marker locations again in case they don't update when deleted/recreated?
{
    _x setMarkerPos (getMarkerPos _x);
} forEach ["bis_fnc_moduleCoverMap_border", "bis_fnc_moduleCoverMap_0", "bis_fnc_moduleCoverMap_90", "bis_fnc_moduleCoverMap_180", "bis_fnc_moduleCoverMap_270"];