class Kits {
    class baseKit {
        scope = 1;
        // personalization for multiple selects.
        uniform[] = {
            "meu_marpatw_frog_d", "meu_marpatw_frog_u"
        };
        vest[] = {
            "meu_vests_spc_01", "meu_vests_spc_02", "meu_vests_spc_03", "meu_vests_spc_04"
        };
        backpack[] = {
            "meu_marpatw_bp_ilbe", "meu_marpatw_bp_fastpack"
        };
        headgear[] = {
            "meu_marpatw_mich2000", "meu_marpatw_boonie_01"
        };
        glasses[] = {
            "rhs_googles_black", "rhs_googles_clear", "rhs_googles_orange", "rhs_googles_yellow",
            "G_Lowprofile",
            "Mask_M40", "Mask_M50"
        };

        // content of containers
        UniformContainer[] = {
            "ACE_EarPlugs", "Chemlight_green", "Chemlight_blue"
        };

        VestContainer[] = {
            "MEU_IFAK", "ACE_CableTie", "ACE_CableTie", "ACE_CableTie"
            "rhs_mag_an_m8hc", "rhs_mag_an_m8hc", "ACE_M84", "ACE_M84"
        };

        BackpackContainer[] = {
            "meu_goggles_tacticalxt_tan", "ACE_DefusalKit", "ACE_IR_Strobe_Item", "rhs_mag_an_m8hc", "ACE_M84", "ACE_M84",
            "rhs_mag_m67", "rhs_mag_m67"
        };

        linkedItems[] = {
            "Itemwatch", "ItemCompass", "ItemMap", "meu_prc153"
        };

        primaryWeapon[] = {};
        secondaryWeapon[] = {};

        sideWeapon[] = {};

    };

    class SquadLeader: baseKit {
        scope = 2;
        displayName = "Squad Leader";

    };

    class Corpsman: baseKit {
        scope = 2;
        displayName = "Corpsman";
    };

    class TeamLeader: baseKit {
        scope = 2;
        displayName = "Fire Team Leader";
    };

    class AutoRifleman: baseKit {
        scope = 2;
        displayName = "Auto. Rifleman";
    };

    class AsstAutoRifleman: baseKit {
        scope = 2;
        displayName = "Asst. Auto. Rifleman";
    };

    class Rifleman: baseKit {
        scope = 2;
        displayName = "Rifleman";
    };

    class AmmoBearer: baseKit {
        scope = 2;
        displayName = "Ammo Bearer";
    };

    class Marksman: baseKit {
        scope = 2;
        displayName = "Marksman";
    };
};
