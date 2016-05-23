class Params {
    class f_param_mission_timer {
        title = "Safe Start (Minutes)";
        values[] = {0,1,2,3,4,5,6,7,8,9,10,15};
        texts[] = {"Off","1","2","3","4","5","6","7","8","9","10 (default)","15"};
        default = 10;
        code = "f_param_mission_timer = %1";
    };
    
    // Auto PVP Mission Specific
    class bc_auto_timeLimit {
        title = "Time Limit:";
        values[] = {5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90};
        texts[] = {"5 minutes","10 minutes","15 minutes","20 minutes","25 minutes","30 minutes","35 minutes","40 minutes","45 minutes (default)","50 minutes","55 minutes","60 minutes","65 minutes","70 minutes","75 minutes","80 minutes","85 minutes","90 minutes",};
        default = 45;
    };
    class bc_auto_sectorTime {
        title = "Cumulative Time to Capture Sector:";
        values[] = {5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90};
        texts[] = {"5 minutes","10 minutes","15 minutes","20 minutes (default)","25 minutes","30 minutes","35 minutes","40 minutes","45 minutes","50 minutes","55 minutes","60 minutes","65 minutes","70 minutes","75 minutes","80 minutes","85 minutes","90 minutes",};
        default = 20;
    };
    class bc_auto_AOSize {
        title = "Battlefield Radius:";
        values[] = {100,200,300,400,500,600,700,800,900,1000};
        texts[] = {"100 meters","200 meters","300 meters","400 meters","500 meters (default)","600 meters","700 meters","800 meters","900 meters","1000m"};
        default = 500;
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
        title = "GPS Deployment (Requires Map):";
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