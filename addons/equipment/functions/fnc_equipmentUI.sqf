/*
 * Author: Thrax
 * Equipment dialog manager function
 *
 * Arguments:
 * 0: Action to execute <STRING>
 * 1: Parameters <ANY>
 *
 * Return Value:
 * -
 *
 * Example:
 * ["onLoad",_this] call FUNC(equipmentUI)
 *
 * Public: [No]
 */
#include "script_component.hpp"

disableSerialization;
private ["_action", "_params", "_display"];
_action = _this select 0;
_params = _this select 1;

_display = GETUVAR(GVAR(EquipmentDisplay),displayNull);

switch _action do {

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "onLoad": {
		SETUVAR(GVAR(EquipmentDisplay),(_params select 0));
    };
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "open": {
        private ["_actionParams", "_type"];
        _actionParams = _params select 3;
        _type = _actionParams select 0;

        GVAR(Updating) = false;
        GVAR(Reset) = true;
        
        GVAR(EnableCamera) = _actionParams select 1;
        GVAR(EnableNV) = _actionParams select 2;
        GVAR(EnableSaveLoad) = _actionParams select 3;
        GVAR(EnablePersistence) = _actionParams select 4;
        GVAR(EnablePresets) = _actionParams select 5;
        GVAR(PresetsArray) = _actionParams select 6;
        GVAR(Info) = _actionParams select 7;
        GVAR(Classnames) = _actionParams select 8;
        GVAR(PresetsOnly) = _actionParams select 9;
        GVAR(Insignias) = _actionParams select 10;
        GVAR(EnableDefaultProfiles) = _actionParams select 11;
        GVAR(SetPersonalData) = _actionParams select 12;
        GVAR(AllowVirtualLoad) = _actionParams select 13;

        //Only update configuration if it's the first use or a different configuration was called
        if(isNil QGVAR(ConfigID) || {GVAR(ConfigID) != _type}) exitWith {
            GVAR(ConfigID) = _type;
            [_type] call FUNC(readConfig);
        } else {
            ["createDialog", ""] call FUNC(equipmentUI);
        };
    };
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "createDialog": {
        createDialog "RscMEU_Equipment";
		
		//Set config title
		 private ["_title", "_buttonCamera", "_buttonNV", "_buttonSave", "_buttonLoad", "_buttonLoadDefault", "_buttonLoadVR"];
        _title = DCONTROL(IDC_RSCMEUEQUIPMENT_TITLE);
        _title ctrlSetText format["%1 - [%2]", localize "STR_MEU_Equipment_ModuleEquipment_Action_defaultValue", GVAR(ConfigType)];
		
		//TODO----------------
        //Camera
        if (GVAR(EnableCamera)) then {
            ["Init"] call FUNC(camera);
            GVAR(NV) = false;

            //Disable NV
            if (!GVAR(EnableNV)) then {
				_buttonNV = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONNV);
				_buttonNV ctrlShow false;
				_buttonNV ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
            };
            
        } else {
            //Disable buttons
			_buttonCamera = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONCAMERA);
			_buttonCamera ctrlShow false;
			_buttonCamera ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
			_buttonNV = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONNV);
			_buttonNV ctrlShow false;
			_buttonNV ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
        };

        //Save/Load system
        if (!GVAR(EnableSaveLoad)) then {
			_buttonSave = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONSAVE);
			_buttonSave ctrlShow false;
			_buttonSave ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
			_buttonLoad = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONLOAD);
			_buttonLoad ctrlShow false;
			_buttonLoad ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
        };

        //Default profiles
        if (!GVAR(EnableDefaultProfiles)) then {
			_buttonLoadDefault = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONLOADDEFAULT);
			_buttonLoadDefault ctrlShow false;
			_buttonLoadDefault ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
        };

        if (!GVAR(AllowVirtualLoad)) then {
			_buttonLoadVR = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTONLOADVR);
			_buttonLoadVR ctrlShow false;
			_buttonLoadVR ctrlSetTooltip "DISABLED"; //TODO LOCALIZE
        };
		
		["equipmentView", ""] call FUNC(equipmentUI);
    };
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "equipmentView": {
	    private ["_list1_title", "_list1", "_labelType", "_comboType", "_labelSide", "_comboSide", "_buttonEquip", "_buttonReplace", "_types"];

		//Set display elements
		_list1_title = DCONTROL(IDC_RSCMEUEQUIPMENT_LIST1_TITLE);
		_list1_title ctrlSetPosition [0.04, 0.09, 0.55, 0.04];
		_list1_title ctrlCommit 0;
		_list1_title ctrlShow true;
		_list1_title ctrlSetText ""; //TODO
		
		_list1 = DCONTROL(IDC_RSCMEUEQUIPMENT_LIST1);
		_list1 ctrlSetPosition [0.04, 0.13, 0.55, 0.72];
		_list1 ctrlCommit 0;
		_list1 ctrlShow true;
		
		_labelType = DCONTROL(IDC_RSCMEUEQUIPMENT_LABEL1);
		_labelType ctrlSetPosition [0.65, 0.3, 0.10, 0.04];
		_labelType ctrlCommit 0;
		_labelType ctrlShow true;
		_labelType ctrlSetText ""; //TODO
		
		_comboType = DCONTROL(IDC_RSCMEUEQUIPMENT_COMBO1);
		_comboType ctrlSetPosition [0.65, 0.35, 0.20, 0.04];
		_comboType ctrlCommit 0;
		_comboType ctrlShow true;
		_comboType ctrlAddEventHandler ["LBSelChanged", QUOTE(['update',[true]] call FUNC(equipmentUI))];
		
		_labelSide = DCONTROL(IDC_RSCMEUEQUIPMENT_LABEL2);
		_labelSide ctrlSetPosition [0.65, 0.4, 0.10, 0.04];
		_labelSide ctrlCommit 0;
		_labelSide ctrlShow true;
		_labelSide ctrlSetText ""; //TODO
		
		_comboSide = DCONTROL(IDC_RSCMEUEQUIPMENT_COMBO2);
		_comboSide ctrlSetPosition [0.65, 0.45, 0.20, 0.04];
		_comboSide ctrlCommit 0;
		_comboSide ctrlShow true;
		_comboSide ctrlAddEventHandler ["LBSelChanged", QUOTE(['update',[false]] call FUNC(equipmentUI);)];

		_buttonEquip = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTON1);
		_buttonEquip ctrlSetPosition [0.65, 0.60, 0.1562, 0.04];
		_buttonEquip ctrlCommit 0;
		_buttonEquip ctrlShow true;
		_buttonEquip ctrlAddEventHandler ["ButtonClick", QUOTE(['addItem',[false]] call FUNC(equipmentUI);)];

		_buttonReplace = DCONTROL(IDC_RSCMEUEQUIPMENT_BUTTON2);
		_buttonReplace ctrlSetPosition [0.65, 0.66, 0.1562, 0.04];
		_buttonReplace ctrlCommit 0;
		_buttonReplace ctrlShow true;
		_buttonReplace ctrlAddEventHandler ["ButtonClick", QUOTE(['addItem',[true]] call FUNC(equipmentUI);)];

		//Hide unused elements
		{
			private "_ctrl";
			_ctrl = DCONTROL(_x);
			_ctrl ctrlShow false;
		} forEach [IDC_RSCMEUEQUIPMENT_LIST2_TITLE, IDC_RSCMEUEQUIPMENT_LIST2];

        //Add item types
        _types = [];
        if (!GVAR(PresetsOnly)) then {
            _types set[0, localize "STR_MEU_Equipment_ModuleEquipment_Uniforms"];
            _types set[1, localize "STR_MEU_Equipment_ModuleEquipment_Vests"];
            _types set[2, localize "STR_MEU_Equipment_ModuleEquipment_Backpacks"];
            _types set[3, localize "STR_MEU_Equipment_ModuleEquipment_Headgear"];
        };
        _types pushBack (localize "STR_MEU_Equipment_ModuleEquipment_Goggles");

        if (GVAR(Insignias)) then {
            _types pushBack (localize "STR_MEU_Equipment_ModuleEquipment_Insignias");
        };

        if (GVAR(EnablePresets)) then {
            _types pushBack (localize "STR_MEU_Equipment_ModuleEquipment_Presets");
        };

		lbClear _comboType;
        { _comboType lbAdd _x; } forEach _types;
        _comboType lbSetCurSel 0;

        //Add factions from configuration
		lbClear _comboSide;
        _comboSide lbAdd localize "STR_MEU_Equipment_ModuleEquipment_Type_all";
        { _comboSide lbAdd _x; } forEach GVAR(UniformFactions);
        _comboSide lbSetCurSel 0;
	};
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "switchCamera": {
        if(GVAR(EnableCamera)) then {
            GVAR(CamPos) = nil;
            ["Exit"] call FUNC(camera);
            ["Init"] call FUNC(camera);
        } else {
            titleText[(localize "STR_MEU_Equipment_OptionDisabled"), "PLAIN DOWN"];
        };
    };
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "switchNV": {
        if (GVAR(EnableCamera)) then {
            if (GVAR(NV)) then {
                camUseNVG false;
                GVAR(NV) = false;
            } else {
                camUseNVG true;
                GVAR(NV) = true;
            };
        };
    };
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "update": {
        private ["_comboType", "_comboSide", "_list", "_resetSide", "_type", "_side", "_collection", "_tooltip", "_load", "_protection", "_vconfig", "_index", "_insignias"];

        //If a reset was called, do nothing
        if (GVAR(Reset)) exitWith { GVAR(Reset) = false; };

        //If an update is already on progress, wait for it to finish and then call update again
        if (GVAR(Updating)) exitWith {
            [{
                if (!GVAR(Updating)) then {
                    [_this select 1] call CBA_fnc_removePerFrameHandler;
                    ["update", _params select 0] call FUNC(equipmentUI);
                };
            
            }, 0.5, []] call CBA_fnc_addPerFrameHandler;
        };

        GVAR(Updating) = true;

        _comboType = DCONTROL(IDC_RSCMEUEQUIPMENT_COMBOTYPE);
        _comboSide = DCONTROL(IDC_RSCMEUEQUIPMENT_COMBOSIDE);
        _list = DCONTROL(IDC_RSCMEUEQUIPMENT_LIST1);

        _resetSide = _params select 0;
        _type = lbCurSel _comboType;
        _side = lbCurSel _comboSide;
        _collection = [];

        if (_resetSide) then {
            _side = 0;
            GVAR(Reset) = true;
            _comboSide lbSetCurSel 0;
        };

        if (_side == -1) then { _side = 0; };

        lbClear _list;
        lbClear _comboSide;
        _comboSide lbAdd (localize "STR_MEU_Equipment_ModuleEquipment_Type_all");

        if (GVAR(PresetsOnly)) then { _type = _type + 4; };

        if (!GVAR(Insignias) && GVAR(EnablePresets)) then { _type = _type + 1; };

        switch (_type) do {
            case 0: {
                GVAR(Type) = 0;
                
                //Set available factions
                { _comboSide lbAdd _x; } forEach GVAR(UniformFactions);
                
                //Check side
                if(_side == 0) then {
                    { { _collection pushBack _x; } forEach _x; } forEach GVAR(Uniforms);
                } else {
                    _collection = GVAR(Uniforms) select (_side - 1);
                };

                //Add elements to listbox
                {
                    _vconfig = configFile >> "CfgWeapons" >> _x;
                    _index = _list lbAdd (getText(_vconfig >> "displayName"));
                    _list lbSetData [_index, _x];
                    _list lbSetPicture [_index, getText(_vconfig >> "picture")];
                    
                    if ((getText (_vconfig >> "DLC")) != "") then {
                        _list lbSetColor [_index, [1,1,0,1]];
                    };
                    
                    _tooltip = "";
                    if (GVAR(Info)) then {
                        _tooltip = (localize "STR_MEU_Equipment_ModuleEquipment_Capacity") + ": " + ([getText (_vconfig >> "ItemInfo" >> "containerClass"), "Supply", ""] call CBA_fnc_replace);
                    };
                    if (GVAR(Classnames)) then { _tooltip = _tooltip + format[" [%1]", _x]; };    
                    if (_tooltip != "") then { _list lbSetTooltip [_index, _tooltip]; };
                } forEach _collection;
            };
            
            case 1: {
                GVAR(Type) = 1;

                //Set available factions
                { _comboSide lbAdd _x; } forEach GVAR(VestFactions);
                
                //Check side
                if(_side == 0) then {
                    { { _collection pushBack _x; } forEach _x; } forEach GVAR(Vests);
                } else {
                    _collection = GVAR(Vests) select (_side - 1);
                };
                
                //Add elements to listbox
                {
                    _vconfig = configFile >> "CfgWeapons" >> _x;
                    _index = _list lbAdd (getText(_vconfig >> "displayName"));
                    _list lbSetData [_index, _x];
                    _list lbSetPicture [_index, getText(_vconfig >> "picture")];

                    _tooltip = "";
                    if (GVAR(Info)) then {
                        _tooltip = (localize "STR_MEU_Equipment_ModuleEquipment_Capacity") + ": " + ([getText (_vconfig >> "ItemInfo" >> "containerClass"), "Supply", ""] call CBA_fnc_replace);
                        _tooltip = _tooltip + format[" | %1: %2", localize "STR_MEU_Equipment_ModuleEquipment_Protection", getNumber (_vconfig >> "ItemInfo" >> "armor")];
                    };
                    if (GVAR(Classnames)) then { _tooltip = _tooltip + format[" [%1]", _x]; };    
                    if (_tooltip != "") then { _list lbSetTooltip [_index, _tooltip]; };
                } forEach _collection;
            };
            
            case 2: {
                GVAR(Type) = 2;

                //Set available factions
                { _comboSide lbAdd _x; } forEach GVAR(BackpackFactions);
                
                //Check side
                if(_side == 0) then {
                    { { _collection pushBack _x; } forEach _x; } forEach GVAR(Backpacks);
                } else {
                    _collection = GVAR(Backpacks) select (_side - 1);
                };
                
                //Add elements to listbox
                {
                    _vconfig = configFile >> "CfgVehicles" >> _x;
                    _index = _list lbAdd (getText(_vconfig >> "displayName"));
                    _list lbSetData [_index, _x];
                    _list lbSetPicture [_index, getText(_vconfig >> "picture")];

                    _tooltip = "";
                    if (GVAR(Info)) then { 
                        _tooltip = format["%1: %2", localize "STR_MEU_Equipment_ModuleEquipment_Capacity", getNumber (_vconfig >> "maximumLoad")]; 
                    };
                    if (GVAR(Classnames)) then { _tooltip = _tooltip + format[" [%1]", _x]; };    
                    if (_tooltip != "") then { _list lbSetTooltip[_index, _tooltip]; };
                } forEach _collection;
            };
            
            case 3: {
                GVAR(Type) = 3;

                //Set available factions
                { _comboSide lbAdd _x; } forEach GVAR(HeadgearFactions);
                
                //Check side
                if(_side == 0) then {
                    { {    _collection pushBack _x; } forEach _x; } forEach GVAR(Headgear);
                } else {
                    _collection = GVAR(Headgear) select (_side - 1);
                };
                
                //Add elements to listbox
                {
                    _vconfig = configFile >> "CfgWeapons" >> _x;
                    _index = _list lbAdd (getText(_vconfig >> "displayName"));
                    _list lbSetData [_index, _x];
                    _list lbSetPicture [_index, getText(_vconfig >> "picture")];

                    _tooltip = "";
                    if (GVAR(Info)) then { 
                        _tooltip = format["%1: %2", localize "STR_MEU_Equipment_ModuleEquipment_Protection", getNumber (_vconfig >> "ItemInfo" >> "armor")]; 
                    };
                    if (GVAR(Classnames)) then { _tooltip = _tooltip + format[" [%1]", _x]; };    
                    if (_tooltip != "") then { _list lbSetTooltip [_index, _tooltip]; };
                } forEach _collection;
            };
            
            case 4: {
                GVAR(Type) = 4;
                
                //Set available factions
                { _comboSide lbAdd _x; } forEach GVAR(GoggleFactions);
                
                //Check side
                if(_side == 0) then {
                    { { _collection pushBack _x; } forEach _x; } forEach GVAR(Goggles);
                } else {
                    _collection = GVAR(Goggles) select (_side - 1);
                };

                //Add elements to listbox
                {
                    _vconfig = configFile >> "CfgGlasses" >> _x;
                    _index = _list lbAdd (getText(_vconfig >> "displayName"));
                    _list lbSetData [_index, _x];
                    _list lbSetPicture [_index, getText(_vconfig >> "picture")];
                    
                    if (GVAR(Classnames)) then {
                        _tooltip = "";
                        _tooltip = format["[%1]", _x];
                        _list lbSetTooltip [_index, _tooltip];
                    };
                } forEach _collection;
            };
            
            case 5: {
                GVAR(Type) = 5;
                
                //If insignias are not preloaded fetch them from config (slower)
                if (isNil "MEU_Equipment_AllInsignias") then {
                    _insignias = (configfile >> "CfgUnitInsignia") call BIS_fnc_returnchildren;
                } else {
                    _insignias = GVAR(AllInsignias);
                };
                
                {
                    _index = _list lbAdd (getText (_x >> "displayName"));
                    _list lbSetData [_index, configName _x];
                    _list lbSetPicture [_index, getText (_x >> "texture")];
                } forEach _insignias;
            };
            
            case 6: {
                GVAR(Type) = 6;
            
                //Set available factions
                { _comboSide lbAdd _x; } forEach GVAR(PresetFactions);

                //Check side
                if(_side == 0) then {
                    { { _collection pushBack _x; } forEach _x; } forEach GVAR(Presets);
                } else {
                    _collection = GVAR(Presets) select (_side - 1);
                };

                //Add elements to listbox
                {
                    {
                        _index = _list lbAdd (_x select 0);
                        _list lbSetData [_index, str(_x)];
                        _list lbSetPicture [_index, getText(configFile >> "CfgWeapons" >> (_x select 1) >> "picture")];
                        
                        _load = 0;
                        _protection = 0;
                        _tooltip = "";
                        if (GVAR(Info)) then {
                            _load = _load + parseNumber([getText (configFile >> "CfgWeapons" >> (_x select 1) >> "ItemInfo" >> "containerClass"), "Supply", ""] call CBA_fnc_replace);
                            _load = _load + parseNumber([getText (configFile >> "CfgWeapons" >> (_x select 2) >> "ItemInfo" >> "containerClass"), "Supply", ""] call CBA_fnc_replace);
                            _load = _load + getNumber (configFile >> "CfgVehicles" >> (_x select 3) >> "maximumLoad");
                            _protection = _protection + getNumber (configFile >> "CfgWeapons" >> (_x select 2) >> "ItemInfo" >> "armor");
                            if (((_x select 4) != "G_Diving") && ((_x select 4) != "")) then { //TODO ADD GOGGLES TO PRESETS
                                _protection = _protection + getNumber (configFile >> "CfgWeapons" >> (_x select 4) >> "ItemInfo" >> "armor");
                            };
                            _tooltip = format["%1: %2 | %3: %4", localize "STR_MEU_Equipment_ModuleEquipment_Capacity", _load, localize "STR_MEU_Equipment_ModuleEquipment_Protection", _protection];
                            _list lbSetTooltip[_index, _tooltip];
                        };
                    } forEach _x;
                } forEach [_collection, GVAR(PresetsArray)];
            };

            default {
                ERROR("Error in equipment update function");
            };

        };

        GVAR(Updating) = false;
    };
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "addItem": {
        private ["_list", "_replace", "_selected", "_type", "_items", "_container", "_data", "_insignia"];

        _list = DCONTROL(IDC_RSCMEUEQUIPMENT_LIST1);
        
        _replace = _params select 0;
        _selected = lbCurSel _list;
        _type = GVAR(Type);

        if(_selected != -1) then {
            switch (_type) do {
                case 0: {
                    _items = uniformItems ACE_Player;
                    _insignia = [ACE_Player] call BIS_fnc_getUnitInsignia; 
                    removeUniform ACE_Player;
                    ACE_Player forceAddUniform (_list lbData _selected);
                    
                    //Clear new container items
                    _container = uniformContainer ACE_Player;
                    clearWeaponCargo _container;
                    clearMagazineCargo _container;
                    clearItemCargo _container;
                    
                    if (_replace) then {
                        { ACE_Player addItemToUniform ([_x] call EFUNC(main,processItem)); } forEach _items;
                        if (_insignia != "") then { [ACE_Player, _insignia] call BIS_fnc_setUnitInsignia; };
                    };
                };
                
                case 1: {
                    _items = vestItems ACE_Player;
                    removeVest ACE_Player;
                    ACE_Player addVest (_list lbData _selected);
                    
                    //Clear new container items
                    _container = vestContainer ACE_Player;
                    clearWeaponCargo _container;
                    clearMagazineCargo _container;
                    clearItemCargo _container;
                    
                    if (_replace) then {
                        { ACE_Player addItemToVest ([_x] call EFUNC(main,processItem)); } forEach _items;
                    };
                };
                
                case 2: {
                    _items = backpackItems ACE_Player;
                    removeBackpack ACE_Player;
                    ACE_Player addBackpack (_list lbData _selected);
                    
                    //Clear new container items
                    _container = backpackContainer ACE_Player;
                    clearWeaponCargo _container;
                    clearMagazineCargo _container;
                    clearItemCargo _container;
                    
                    if (_replace) then {
                        { ACE_Player addItemToBackpack ([_x] call EFUNC(main,processItem)); } forEach _items;
                    };
                };
                
                case 3: {
                    removeHeadgear ACE_Player;
                    ACE_Player addHeadgear (_list lbData _selected);
                };
                
                case 4: {
                    removeGoggles ACE_Player;
                    ACE_Player addGoggles (_list lbData _selected);
                };
                
                case 5: {
                    [ACE_Player, _list lbData _selected] call BIS_fnc_setUnitInsignia;
                };
                
                case 6: {
                    removeUniform ACE_Player;
                    removeVest ACE_Player;
                    removeBackpack ACE_Player;
                    removeHeadgear ACE_Player;
                    removeGoggles ACE_Player;
                    
                    _data = call compile format["%1", _list lbData _selected];
                    
                    ACE_Player forceAddUniform (_data select 1);
                    _container = uniformContainer ACE_Player;
                    clearWeaponCargo _container;
                    clearMagazineCargo _container;
                    clearItemCargo _container;
                    
                    ACE_Player addVest (_data select 2);
                    _container = vestContainer ACE_Player;
                    clearWeaponCargo _container;
                    clearMagazineCargo _container;
                    clearItemCargo _container;
                    
                    ACE_Player addBackpack (_data select 3);
                    _container = backpackContainer ACE_Player;
                    clearWeaponCargo _container;
                    clearMagazineCargo _container;
                    clearItemCargo _container;
                    
                    //TODO REMOVE
                    if ((_data select 4) != "") then {
                        if ((_data select 2) == "V_RebreatherB") then {
                            ACE_Player addGoggles (_data select 4);
                        } else {
                            ACE_Player addHeadgear (_data select 4);
                        };
                    };
                };
                
                default {
                    ERROR("Error in equipment addItem function");
                };
            };
        };
    };
    
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case "onUnload": {
        if (GVAR(EnableCamera)) then {
            ["Exit"] call FUNC(camera);
        };
    };
};