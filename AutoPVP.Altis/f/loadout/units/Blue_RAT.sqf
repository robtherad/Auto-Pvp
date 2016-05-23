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
player addVest "CUP_V_B_MTV_Patrol";
for "_i" from 1 to 5 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

player addBackpack "CUP_B_USMC_MOLLE";
player addItemToBackpack "CUP_SMAW_Spotting";
for "_i" from 1 to 4 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {player addItemToBackpack "CUP_SMAW_HEDP_M";};

player addHeadgear "CUP_H_USMC_HelmetWDL";
player addWeapon "CUP_arifle_M4A1";

player addWeapon "CUP_launch_Mk153Mod0";
if (s_loadout_map == 0) then {
    player linkItem "ItemMap";
    if (s_loadout_gps == 0) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";
if (s_loadout_radio == 0) then {
    player linkItem "ItemRadio";
};

missionNamespace setVariable ["bc_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
