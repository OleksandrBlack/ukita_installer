
Var UserID
Var UserID_InputBox
Var UserID_CheckBox
Var UserID_State
Var UserID_Font
Var UserID_Label
Var UserID_Labe2
Var UserID_Labe3
Var UserID_Link1
Var UserID_Link2

Function UserIDPage
;${If} $LANGUAGE == ${LANG_UKRAINIAN} ;UserID temporarily only for Ukraine UNLOCK
	CreateFont $UserID_Font "Microsoft Sans Serif" "8.25" "700"

    nsDialogs::Create 1018

	!insertmacro MUI_HEADER_TEXT "$(userid_title)" "$(userid_subtitle)"

	${NSD_CreateLabel} 30u 1u 259u 35u "$(userid_labe1)"
	Pop $UserID_Label
	${NSD_CreateLink} 93u 40u 100u 10u "https://t.me/itarmy_stat_bot"
	Pop $UserID_Link1
	${NSD_OnClick} $UserID_Link1 BotLink
	${NSD_CreateLabel} 30u 55u 259u 25u "$(userid_labe2)"
	Pop $UserID_Labe2
	${NSD_CreateLabel} 95u 80u 122u 10u "$(userid_labe3)"
	Pop $UserID_Labe3
	${NSD_CreateLink} 90u 90u 110u 10u "https://itarmy.com.ua/statistics"
	Pop $UserID_Link2
	${NSD_OnClick} $UserID_Link2 StatisticsLink
	${NSD_CreateCheckbox} 98u 105u 100u 10u "$(userid_checkbox)"
	Pop $UserID_CheckBox
	${NSD_OnClick} $UserID_CheckBox UserIDCheckChange
    ${NSD_CreateNumber} 111u 120u 66u 12u ""
    Pop $UserID_InputBox
	SendMessage $UserID_InputBox ${WM_SETFONT} $UserID_Font 0
	${NSD_SetTextLimit} $UserID_InputBox 9
	SetCtlColors $UserID_InputBox 0x0066CC 0xE3E3E3
	EnableWindow $UserID_InputBox 0
    nsDialogs::Show
;${EndIf}
FunctionEnd

Function BotLink
	Pop $0
	ExecShell "open" "https://t.me/itarmy_stat_bot"
FunctionEnd

Function StatisticsLink
	Pop $0
	ExecShell "open" "https://itarmy.com.ua/statistics"
FunctionEnd

Function UserIDCheckChange
	${If} $UserID_State == ${BST_CHECKED}
		${NSD_Check} $UserID_CheckBox
	${EndIf}
	${NSD_GetState} $UserID_CheckBox $1
	${If} $1 == 0
		EnableWindow $UserID_InputBox 0
	${Else}
		EnableWindow $UserID_InputBox 1
	${EndIf}
FunctionEnd

Function UserIDPageLeave
    ${NSD_GetText} $UserID_InputBox $UserID
	${NSD_GetState} $UserID_CheckBox $UserID_State
FunctionEnd
