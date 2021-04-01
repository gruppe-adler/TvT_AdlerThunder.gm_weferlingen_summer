/*

    adds self interaction to build bridges
    test: call gradTnT_fnc_bridgeActionBuild;

*/


private _buildAction = [
    "BuildBridge",
    "Build Bridge",
    "functions\bft\data\bridge.paa",
    {
        if (player getVariable ["SB_bridgesBuilt", 0] >= SB_MAX_BRIDGES) exitWith {
            private _string = format ["Bridge Limit of %1 reached. Destroy one of the placed bridges via ACE Interact to be able to build new ones.", SB_MAX_BRIDGES];
            hintSilent _string;
        };
        private _bridgeVehicle = [SB_BRIDGES_VEHICLE_WEST, SB_BRIDGES_VEHICLE_EAST] select ( side player == east );
        private _vehicleNear = false;
        private _canBuild = true;
        if (_bridgeVehicle != "") then {
            if (count (player nearObjects [_bridgeVehicle, SB_BRIDGES_VEHICLE_DISTANCE]) == 0) exitWith {
              private _string = format ["No Engineer Vehicle near your position (needs to be closer than %1 m).", SB_BRIDGES_VEHICLE_DISTANCE];
              hintSilent _string;
              _canBuild = false;
            };
        };
        if (_canBuild) then {
            call gradTnT_fnc_bridgePlace;
        };
    }, {
          vehicle player == player
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[player, 1, ["ACE_SelfActions", "Engineer_Buildings"], _buildAction] call ace_interact_menu_fnc_addActionToObject;
