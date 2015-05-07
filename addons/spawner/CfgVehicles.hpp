class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits {
            class Units;
        };
        class ModuleDescription {
            class AnyBrain;
        };
    };

    class MEU_ModuleVehicleSpawner: Module_F {
        author = "$STR_MEU_Main_MEUTeam";
        _generalMacro = "MEU_ModuleVehicleSpawner";
        scope = 2;
        displayName = "$STR_MEU_Spawner_Name";
        icon = PATHTOF(UI\Icon_Module_Spawner_ca.paa);
        category = "MEU_modules";
        function = QFUNC(moduleSpawner);
        functionPriority = 0;
        isGlobal = 1;
        isTriggerActivated = 0;
        isDisposable = 0;

        class Arguments {
            class Action {
                displayName = "$STR_MEU_Spawner_ActionName";
                description = "$STR_MEU_Spawner_ActionDesc";
                defaultValue = "$STR_MEU_Spawner_Create";
            };

            class Type {
                displayName = "$STR_MEU_Spawner_TypeName";
                description = "$STR_MEU_Spawner_TypeDesc";
                typeName = "NUMBER";
                class values {
                    class ground { name = "$STR_MEU_Spawner_Ground"; value = 0; default = 1; };
                    class air { name = "$STR_MEU_Spawner_Air"; value = 1; };
                    class water { name = "$STR_MEU_Spawner_Water"; value = 2; };
                };
            };

            class Position {
                displayName = "$STR_MEU_Spawner_PositionName";
                description = "$STR_MEU_Spawner_PositionDesc";
                defaultValue = "";
            };

            class Rotation {
                displayName = "$STR_MEU_Spawner_RotationName";
                description = "$STR_MEU_Spawner_RotationDesc";
                defaultValue = "0";
            };

            class Instructor {
                displayName = "$STR_MEU_Spawner_InstructorName";
                description = "$STR_MEU_Spawner_InstructorDesc";
                typeName = "BOOL";
                class values {
                    class yes { name = "$STR_MEU_Main_Yes"; value = 1; default = 1; };
                    class no { name = "$STR_MEU_Main_No"; value = 0; };
                };
            };
        };

        class ModuleDescription: ModuleDescription {
            description = "$STR_MEU_Spawner_Description";
            sync[] = {};
        };
    };
};