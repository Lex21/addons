class Kits {
    class baseKit {
        scope = 1;
        // personalization for multiple selects.
        uniform[] = {
            "TRYK_OVERALL_nok_flesh", "TRYK_OVERALL_SAGE_BLKboots_nk", "TRYK_OVERALL_flesh", "TRYK_OVERALL_SAGE"
        };
        vest[] = {
            "TRYK_V_ArmorVest_CBR", "TRYK_V_ArmorVest_Brown"
        };
        backpack[] = {
            "B_AssaultPack_rgr", "meu_marpatd_bp_fastpack", "rhsusf_assault_eagleaiii_coy"
        };
        headgear[] = {
            "rhsusf_ach_bare_tan_headset", "rhsusf_ach_bare_wood_headset", "rhsusf_ach_bare_headset"
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
            "MEU_IFAK", "ACE_CableTie", "ACE_CableTie", "ACE_CableTie",
            "RH_17Rnd_9x19_g17", "RH_17Rnd_9x19_g17", "RH_17Rnd_9x19_g17",
            "rhs_mag_an_m8hc", "rhs_mag_an_m8hc", "ACE_M84", "ACE_M84"
        };

        BackpackContainer[] = {
            "ACE_DefusalKit", "ACE_IR_Strobe_Item", "rhs_mag_an_m8hc", "ACE_M84", "ACE_M84", "rhs_mag_m67",
            "rhs_mag_m18_red", "rhs_mag_m18_green"
        };

        linkedItems[] = {
            "Itemwatch", "ItemCompass", "ItemMap", "meu_prc153"
        };

        primaryWeapon[] = {};
        secondaryWeapon[] = {};

        sideWeapon[] = {
            "RH_g19", "RH_g19t"
        };

    };
    
    class SquadLeader: baseKit {
        scope = 2;
        displayName = "Squad leader";

        linkedItems[] = {
            "Itemwatch", "ItemCompass", "ItemMap", "tf_anprc152"
        };
    };

    class TeamLeader: baseKit {
        scope = 2;
        displayName = "TeamLeader";
    };

    class Operator: baseKit {
        scope = 2;
        displayName = "Operator";

        VestContainer[] += {
            "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1",
            "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1",
            "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1"
        };

        primaryWeapon[] = {
            "RHARD_MK18_F", "RHARD_MK18AFG_F", "RHARD_MK18P_F",
            "rhs_weap_m4_grip2", "hlc_rifle_CQBR"
        };
    };

    class Operator_MP5: baseKit {
        scope = 2;
        displayName = "Operator (MP5)";

        VestContainer[] = {
            "MEU_30Rnd_MP5_M882", "MEU_30Rnd_MP5_M882", "MEU_30Rnd_MP5_M882", "MEU_30Rnd_MP5_M882",
            "MEU_30Rnd_MP5_M882", "MEU_30Rnd_MP5_M882", "MEU_30Rnd_MP5_M882", "MEU_30Rnd_MP5_HP_S",
            "MEU_30Rnd_MP5_HP_S", "MEU_30Rnd_MP5_HP_S"
        };

        primaryWeapon[] = {
            "hlc_smg_mp5a3", "hlc_smg_mp5a4",
            "hlc_smg_mp5sd5", "hlc_smg_mp5sd6"
        };
    };

    class Operator_Corpsman: Operator {
        scope = 2;
        displayName = "Corpsman";

        backpack[] += {
            "TRYK_B_Medbag"
        };

        VestContainer[] += {
            "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1",
            "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANAG4179_M855A1", "MEU_30Rnd_STANA4179_M855A1",
            "rhs_mag_an_m8hc", "rhs_mag_an_m8hc", "rhs_mag_an_m8hc"
        };

        BackpackContainer[] = {
            MEDIC_BACKPACK_EQUIPMENT
        };
    };

    class AutomaticRifleman: baseKit {
        scope = 2;
        displayName = "Automatic Rifleman";
    };

    class Marksman: baseKit {
        scope = 2;
        displayName = "Marksman";
    };
};