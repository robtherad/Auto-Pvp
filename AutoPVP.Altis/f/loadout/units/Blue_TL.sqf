removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform "CUP_U_B_USMC_MARPAT_WDL_Sleeves";
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
player addVest "CUP_V_B_MTV_Patrol";
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 4 do {player addItemToVest "SmokeShellRed";};
for "_i" from 1 to 5 do {player addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
for "_i" from 1 to 4 do {player addItemToVest "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 4 do {player addItemToVest "1Rnd_SmokeRed_Grenade_shell";};
for "_i" from 1 to 4 do {player addItemToVest "1Rnd_Smoke_Grenade_shell";};

player addWeapon "CUP_arifle_M16A2_GL";
player addPrimaryWeaponItem "acc_flashlight";

if ((s_loadout_radio == 0) or (s_loadout_radio == 1)) then {
    player linkItem "ItemRadio";
};
player addBackpack "CUP_B_USMC_MOLLE";
for "_i" from 1 to 12 do {player addItemToBackpack "CUP_30Rnd_556x45_Stanag";};

player addHeadgear "CUP_H_USMC_HelmetWDL";
player addWeapon "Binocular";
if ((s_loadout_map == 0) or (s_loadout_map == 1)) then {
    player linkItem "ItemMap";
    if ((s_loadout_gps == 0) or (s_loadout_gps == 1)) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";

missionNamespace setVariable ["bc_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
