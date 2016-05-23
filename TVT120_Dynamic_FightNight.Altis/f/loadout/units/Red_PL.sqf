removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform "CUP_U_O_CHDKZ_Kam_02";
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
player addVest "CUP_V_BAF_Osprey_Mk2_DPM_Scout";
for "_i" from 1 to 5 do {player addItemToVest "CUP_30Rnd_545x39_AK_M";};
for "_i" from 1 to 4 do {player addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

player addWeapon "CUP_arifle_AK107";
removeAllPrimaryWeaponItems player;

if (s_loadout_radio != 3) then {
    player linkItem "ItemRadio";
};

player addBackpack "CUP_B_CivPack_WDL";
for "_i" from 1 to 10 do {player addItemToBackpack "CUP_30Rnd_545x39_AK_M";};
player addHeadgear "CUP_H_SLA_Helmet";
player addGoggles "G_Bandanna_khk";

player addWeapon "Binocular";
if (s_loadout_map != 3) then {
    player linkItem "ItemMap";
    if (s_loadout_gps != 3) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";

missionNamespace setVariable ["bc_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
