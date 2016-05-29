// Add clothing
player forceAddUniform "rhsgref_uniform_ttsko_forest";
player addVest "rhsgref_6b23_ttsko_forest_rifleman";
player addBackpack "rhs_assault_umbts";
player addHeadgear "rhsgref_6b27m_ttsko_forest";

// Add gear
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {player addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 5 do {player addItemToVest "rhs_30Rnd_545x39_AK_green";};
for "_i" from 1 to 3 do {player addItemToBackpack "rhs_100Rnd_762x54mmR";};
player addWeapon "rhs_weap_ak74m";
for "_i" from 1 to 5 do {player addItemToVest "rhs_30Rnd_545x39_AK";};
player addWeapon "Binocular";

// Add items
if (s_loadout_map isEqualTo 0) then {
    player linkItem "ItemMap";
    if (s_loadout_gps isEqualTo 0) then {player linkItem "ItemGPS";};
};
player linkItem "ItemCompass";
player linkItem "ItemWatch";
if (s_loadout_radio isEqualTo 0) then {
    player linkItem "ItemRadio";
};

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
