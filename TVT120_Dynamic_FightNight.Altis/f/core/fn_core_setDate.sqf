date params ["_year", "_month", "_day", "_hour", "_minute"];

_paramTime = ["phx_core_timeOfDay",-1] call BIS_fnc_getParamValue;

if !(_paramTime isEqualTo -1) then {
    // Use parameter setting
    _timeArray = switch (_paramTime) do {
        case 0: { [6,0] }; // Dawn
        case 1: { [12,0] }; // Noon
        case 2: { [18,0] }; // Dusk
        case 3: { [0,0] }; // Midnight
    };
    _timeArray params ["_realHour", "_realMinute"];
    setDate [_year, _month, _day, _realHour, _realMinute];
} else {
    // Use the mission's time setting
    setDate [_year, _month, _day, _hour, _minute];
};