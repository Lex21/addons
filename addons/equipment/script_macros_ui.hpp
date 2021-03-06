//--- RscMEU_Equipment controls
#define IDC_RSCMEUEQUIPMENT_BACKGROUND              11000
#define IDC_RSCMEUEQUIPMENT_MOUSEAREA               11001
#define IDC_RSCMEUEQUIPMENT_TITLE                   11002
#define IDC_RSCMEUEQUIPMENT_LIST1_TITLE             11003
#define IDC_RSCMEUEQUIPMENT_LIST2_TITLE             11004
#define IDC_RSCMEUEQUIPMENT_LIST1                   11005
#define IDC_RSCMEUEQUIPMENT_LIST2                   11006
#define IDC_RSCMEUEQUIPMENT_LABEL1                  11007
#define IDC_RSCMEUEQUIPMENT_LABEL2                  11008
#define IDC_RSCMEUEQUIPMENT_BUTTON1                 11009
#define IDC_RSCMEUEQUIPMENT_BUTTON2                 11010
#define IDC_RSCMEUEQUIPMENT_COMBO1                  11012
#define IDC_RSCMEUEQUIPMENT_COMBO2                  11013
#define IDC_RSCMEUEQUIPMENT_TEXTBOX                 11014
#define IDC_RSCMEUEQUIPMENT_BUTTONCAMERA            11015
#define IDC_RSCMEUEQUIPMENT_BUTTONNV                11016
#define IDC_RSCMEUEQUIPMENT_BUTTONSAVE              11017
#define IDC_RSCMEUEQUIPMENT_BUTTONLOAD              11018
#define IDC_RSCMEUEQUIPMENT_BUTTONLOADVR            11019
#define IDC_RSCMEUEQUIPMENT_BUTTONCLIPBOARDCOPY     11020
#define IDC_RSCMEUEQUIPMENT_BUTTONCLIPBOARDPASTE    11021
#define IDC_RSCMEUEQUIPMENT_BUTTONSENDLOADOUT       11022

//--- RscMEU_Equipment script macros
#define DCONTROL(IDC) _display displayCtrl IDC
#define DCURPOSX ((ctrlPosition _background) select 0)
#define DCURPOSY ((ctrlPosition _background) select 1)

//--- RscMEU_ReceiveEquipment controls
#define IDC_RSCMEURECEIVEEQUIPMENT_LABEL            11030