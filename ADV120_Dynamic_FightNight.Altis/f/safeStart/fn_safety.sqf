// F3 - Safe Start, Safety Toggle
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
//=====================================================================================

// Exit if server
if (!hasInterface) exitwith {};
waitUntil {!isNull player};
switch (_this select 0) do
{
    // Turn safety on
    case true:
    {
        phx_safeStartEnabled = true;
        
        // Delete bullets from fired weapons
        if (isNil "f_eh_safetyMan") then {
            f_eh_safetyMan = player addEventHandler["Fired", {
                params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
                
                deletevehicle _projectile;
                "phx_safeStartTextLayer" cutText ["SAFESTART ACTIVE", "PLAIN", 0];
                "phx_safeStartTextLayer" cutFadeOut 3;
                if (_weapon isEqualTo "Throw" || {_weapon isEqualTo "Put"}) then {
                    player addMagazine _magazine;
                } else {
                    private _ammo = player ammo _weapon;
                    if (_ammo > 0) then {
                        player setAmmo [_weapon, _ammo+1];
                    } else {
                        player addMagazine _magazine;
                        player removeWeapon _weapon;
                        player addWeapon _weapon;
                    };
                };
            }];
        };

        // Make player invincible
        player allowDamage false;
    };

    // Turn safety off
    case false;
    default {
        // Allow player to fire weapons
        if !(isNil "f_eh_safetyMan") then {
            player removeEventhandler ["Fired", f_eh_safetyMan];
            f_eh_safetyMan = nil;
        };

        // Re-enable guns and damage for vehicles if they were disabled
        if !(isNull(player getVariable ["f_var_safetyVeh",objnull])) then {
            (player getVariable "f_var_safetyVeh") allowDamage true;

            if !(isNil "f_eh_safetyVeh") then {
                (player getVariable "f_var_safetyVeh") removeeventhandler ["Fired", f_eh_safetyVeh];
                f_eh_safetyVeh = nil;
            };
            player setVariable ["f_var_safetyVeh",nil];
        };
        
        // Make player vulnerable
        player allowDamage true;
        phx_safeStartEnabled = false;
        
        // AUTO PVP CODE - Moves player to the team's real starting location. Preserves editor placement formation.
            titleText ["You have been teleported to your team's starting location.\n\nGood luck.", "PLAIN DOWN", 1];
            // Returns a position that is a specified distance and compass direction from the passed position or object.
            private _newPos = phx_auto_ownTeamStart getPos [phx_rs_distance, phx_rs_direction];

            // Move player
            player setPos [(_newPos select 0), (_newPos select 1)];
            player setDir (phx_auto_ownTeamStart getDir phx_auto_centerLocation);
    };
};