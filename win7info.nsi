Var txt
Var myTextBox
Var CheckBox1

Function MyPageFunc
    nsDialogs::Create 1018
	
	  ; === CheckBox1 (type: Checkbox) ===
  ${NSD_CreateCheckbox} 115u 36u 68u 15u "CheckBox1"
  Pop $CheckBox1
  
${NSD_OnClick} $CheckBox1 nsDialogsPageCheckChange



    ${NSD_CreateLabel} 0 0 50u 10u "Username:"
    ${NSD_CreateText} 70 0 100u 12u ""
    Pop $myTextBox
	EnableWindow $myTextBox 0
    nsDialogs::Show
FunctionEnd

Function nsDialogsPageCheckChange
${NSD_GetState} $CheckBox1 $1
${If} $1 == 0
	EnableWindow $myTextBox 0
${Else}
	EnableWindow $myTextBox 1
${EndIf}
FunctionEnd

Function MyPageFuncLeave
    ${NSD_GetText} $myTextBox $txt
FunctionEnd


Var info_down_btn
Var info_label_1
Var info_label_2
Var info_font

Function Page_Win7Info
${If} ${IsWin7}
  ; custom font definitions
  CreateFont $info_font "Microsoft Sans Serif" "9.75" "700"
  
  ; === info (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $0
	
  !insertmacro MUI_HEADER_TEXT $(inf_title) $(inf_subtitle)
  
  ; === down_btn (type: Button) ===
  ${NSD_CreateButton} 217u 106u 64u 15u $(inf_button)
  Pop $info_down_btn
  ${NSD_OnClick} $info_down_btn download_updater
  
  ; === label_1 (type: Label) ===
  ${NSD_CreateLabel} 8u 20u 280u 28u $(inf_lable_1)
  Pop $info_label_1
  SendMessage $info_label_1 ${WM_SETFONT} $info_font 0
  
  ; === label_2 (type: Label) ===
  ${NSD_CreateLabel} 8u 71u 273u 22u $(inf_lable_2)
  Pop $info_label_2
  
	nsDialogs::Show
${EndIf}
FunctionEnd

Function download_updater
    ExecShell "open" "https://update7.simplix.info/UpdatePack7R2.exe" 
FunctionEnd