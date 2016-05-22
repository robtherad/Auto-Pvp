class Params {
    class f_param_mission_timer {
        title = "Safe Start (Minutes)";
        values[] = {0,1,2,3,4,5,6,7,8,9,10,15};
        texts[] = {"Off","1","2","3","4","5","6","7","8","9","10","15"};
        default = 10;
        code = "f_param_mission_timer = %1";
    };
    
    // Auto PVP Mission Specific
    class bc_auto_timeLimitMod {
        title = "Time Limit Modifier:";
        values[] = {0,1,2,3,4};
        texts[] = {"Very Short (50%)", "Short (75%)", "Normal (100%)", "Long (125%)", "Very Long (150%)"};
        default = 2;
    };
    class bc_auto_AOSizeMod {
        title = "Battlefield Size Modifier:";
        values[] = {0,1,2,3,4};
        texts[] = {"Very Small (50%)", "Small (75%)", "Normal (100%)", "Large (125%)", "Very Large (150%)"};
        default = 2;
    };
    class bc_showOtherTeamStart {
        title = "Show Enemy Starting Location to:";
        values[] = {0,1,2,3};
        texts[] = {"Nobody","BLUFOR Only","OPFOR Only","Everybody"};
        default = 0;
    };
    
    // Generic Loadout Stuff
    class s_loadout_radio {
        title = "Radio Deployment:";
        values[] = {0,1,2,3};
        texts[] = {"All Players (default)","Team Leaders and above","Squad Leaders and above","No Radios"};
        default = 0;
    };
    class s_loadout_map {
        title = "Map Deployment:";
        values[] = {0,1,2,3};
        texts[] = {"All Players (default)","Team Leaders and above","Squad Leaders and above","No Maps"};
        default = 0;
    };
    class s_loadout_gps {
        title = "GPS Deployment (Requires map):";
        values[] = {0,1,2,3};
        texts[] = {"All Players (default)","Team Leaders and above","Squad Leaders and above","No GPS"};
        default = 0;
    };
    class s_gps_markers {
        title = "GPS Map Markers:";
        values[] = {0,1};
        texts[] = {"Disabled","Enabled (default)"};
        default = 1;
    };
    class bc_param_enableRadioPreset {
        title = "Enable Preset Radios:";
        values[] = {true,false};
        texts[] = {"Enabled","Disabled"};
        default = true;
    };
};