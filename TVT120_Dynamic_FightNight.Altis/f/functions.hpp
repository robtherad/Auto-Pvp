class core {
    file = "f\core";
    class core_addKilledEH{postInit = 1;};
    class core_mpKilled{};
    class core_showTags{};
    class core_addRatingEH{postInit = 1;};
    class core_playerBoundsCheck{};
};
class radios {
    file = "f\radios";
    class radio_genFreqs{postInit = 1;};
    class radio_waitGear{};
    class radio_getChannels{};
    class radio_waitRadios{};
    class radio_setRadios{};
    class radio_cleanup{};
};
class loadout {
    file = "f\loadout";
    class loadout_set{postInit = 1;};
    class loadout_notes{};
};
class gpsmarkers {
    file = "f\gpsmarkers";
    class gps_init{};
    class gps_createMarks{};
    class gps_updateMarks{};
};
class endConditions {
    file = "f\endconditions";
    class end_clientWait{};
    class end_clientTime{};
    class end_checkTime{};
    class end_checkAlive{};
};
class misc {
    file = "f\misc";
    class _clearBody{};
    class _clearContainer{};
    class _hintThenClear{};
    class serverJIP{postInit = 1;};
    class clientJIP{postInit = 1;};
};
class autoPvp {
    file = "f\autoPvp";
    class serverPostInit{postInit = 1};
    class chooseRandomCenter{};
    class findTeamStarts{};
    class foundPositions{};
    class coverMap{};
};
class autoPvpSector {
    file = "f\autoPvp\sector";
    class createSector{};
    class watchSector{};
    class pointsDisplay{postInit = 1;};
    class titleTextSector{};
};
class autoPvpplace {
    file = "f\autoPvp\placement";
    class placeMove{};
    class placeWait{postInit = 1;};
};