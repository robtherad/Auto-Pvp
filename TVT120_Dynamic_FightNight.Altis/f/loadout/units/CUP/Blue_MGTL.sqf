// Add clothing
player forceAddUniform "CUP_U_B_USMC_MARPAT_WDL_Sleeves";
player addVest "CUP_V_B_MTV_Patrol";
player addBackpack "CUP_B_USMC_MOLLE";
player addHeadgear "CUP_H_USMC_HelmetWDL";

// Add gear
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 7 do {player addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Red";};
for "_i" from 1 to 5 do {player addItemToVest "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 4 do {player addItemToVest "1Rnd_Smoke_Grenade_shell";};
for "_i" from 1 to 4 do {player addItemToVest "UGL_FlareWhite_F";};
player addWeapon "CUP_arifle_M16A2_GL";
for "_i" from 1 to 6 do {player addItemToBackpack "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {player addItemToBackpack "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M";};
player addWeapon "Binocular";

// Add items
if ((phx_loadout_map == 0) or (phx_loadout_map == 1)) then {
    player linkItem "ItemMap";
    if ((phx_loadout_gps == 0) or (phx_loadout_gps == 1)) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";
if ((phx_loadout_radio == 0) or (phx_loadout_radio == 1)) then {
    player linkItem "ItemRadio";
};

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
