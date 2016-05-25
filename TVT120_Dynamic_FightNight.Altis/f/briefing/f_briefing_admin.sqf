// F3 - Briefing
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// ADMIN BRIEFING
// This is a generic section displayed only to the ADMIN

_briefing ="
<br/>
<font size='18'>ADMIN SECTION</font><br/>
This briefing section can only be seen by the current admin.
<br/><br/>
";

// SAFE START SECTION

_briefing = _briefing + "
<font size='18'>SAFE START CONTROL</font><br/>
|- <execute expression=""f_var_mission_timer = f_var_mission_timer + 1; publicVariable 'f_var_mission_timer'; hintsilent format ['Mission Timer: %1',f_var_mission_timer];"">
Increase Safe Start timer by 1 minute</execute><br/>

|- <execute expression=""f_var_mission_timer = f_var_mission_timer - 1; publicVariable 'f_var_mission_timer'; hintsilent format ['Mission Timer: %1',f_var_mission_timer];"">
Decrease Safe Start timer by 1 minute</execute><br/>

|- <execute expression=""f_var_mission_timer = -1; publicVariable 'f_var_mission_timer';
[['SafeStartMissionStarting',['Mission starting now!']],'bis_fnc_showNotification',true] call BIS_fnc_MP;
[[false],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safe Start ended!';"">
End Safe Start timer and start battle</execute><br/><br/>
";

// AUTO PVP SECTION
// SAFE START SECTION

_briefing = _briefing + "
<font size='18'>AUTO PVP CONTROL</font><br/>
|- <execute expression=""if (getClientStateNumber isEqualTo 9) then {[] remoteExec ['phx_fnc_serverPostInit',2];} else {systemChat 'You need to be at the briefing screen to choose a new battlefield.';};"">
Choose new battlefield (BRIEFING SCREEN ONLY)</execute><br/>
";

// ====================================================================================

// CREATE DIARY ENTRY

player createDiaryRecord ["PHX_Diary", ["Admin Menu",_briefing]];

// ====================================================================================