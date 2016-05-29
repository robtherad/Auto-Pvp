comment "Exported from Arsenal by robtherad";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "rhsgref_uniform_ttsko_forest";
for "_i" from 1 to 2 do {this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {this addItemToUniform "SmokeShell";};
this addVest "rhsgref_6b23_ttsko_forest_rifleman";
for "_i" from 1 to 3 do {this addItemToVest "rhs_30Rnd_545x39_AK";};
this addBackpack "rhs_assault_umbts";
this addHeadgear "rhsgref_6b27m_ttsko_forest";

comment "Add weapons";
this addWeapon "rhs_weap_ak74m_gp25";
this addPrimaryWeaponItem "rhs_acc_dtk";
this addPrimaryWeaponItem "rhs_acc_1p29";
this addWeapon "Binocular";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "tf_anprc148jem_5";
this linkItem "ItemGPS";

comment "Set identity";
this setFace "AfricanHead_03";
this setSpeaker "Male01GRE";
