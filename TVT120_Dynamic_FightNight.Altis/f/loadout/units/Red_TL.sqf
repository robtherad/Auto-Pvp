removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform "rhsgref_uniform_ttsko_forest";
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
player addVest "rhsgref_6b23_ttsko_forest_rifleman";
for "_i" from 1 to 5 do {player addItemToVest "rhs_VOG25";};
for "_i" from 1 to 4 do {player addItemToVest "rhs_GRD40_White";};
for "_i" from 1 to 4 do {player addItemToVest "rhs_VG40OP_white";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
player addBackpack "rhs_assault_umbts";
for "_i" from 1 to 5 do {player addItemToBackpack "rhs_30Rnd_545x39_AK_green";};
player addHeadgear "rhsgref_6b27m_ttsko_forest";

player addWeapon "rhs_weap_ak74m_gp25";
for "_i" from 1 to 10 do {player addItemToBackpack "rhs_30Rnd_545x39_AK";};

player addWeapon "Binocular";
if ((s_loadout_radio == 0) or (s_loadout_radio == 1)) then {
    player linkItem "ItemRadio";
};
if ((s_loadout_map == 0) or (s_loadout_map == 1)) then {
    player linkItem "ItemMap";
    if ((s_loadout_gps == 0) or (s_loadout_gps == 1)) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
