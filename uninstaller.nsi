;Uninstaller Section

Section "Uninstall"
  
  Delete "$DESKTOP\Атака ІТ армії України.lnk"
  Delete "$DESKTOP\ItArmy of Ukraine Attack.lnk"
  Delete "$DESKTOP\Атака ІТ армии Украины.lnk"
  ;Delete "$DESKTOP\Атака ІТ армії України (BETA).lnk"
  ;Delete "$DESKTOP\ItArmy of Ukraine Attack (BETA).lnk"
  ;Delete "$DESKTOP\Атака ІТ армии Украины (BETA).lnk"
  Delete "$DESKTOP\Шукач Проксі (Шукати проксі для mhddos_proxy).lnk"
  Delete "$DESKTOP\Proxy Finder (Find proxies for mhddos_proxy).lnk"
  Delete "$DESKTOP\Искатель Прокси (Искать прокси для mhddos_proxy).lnk"
  Delete "$DESKTOP\Атака ІТ армії України_POWERFULL.lnk"
  Delete "$DESKTOP\ItArmy of Ukraine Attack_POWERFULL.lnk"
  Delete "$DESKTOP\Атака ІТ армии Украины_POWERFULL.lnk"
  Delete "$DESKTOP\MHDDOS_PROXY.lnk"
  Delete "$DESKTOP\MHDDOS_PROXY_POWERFULL.lnk"
  Delete "$DESKTOP\DB1000N.lnk"
  Delete "$DESKTOP\PROXY_FINDER.lnk"
  Delete "$DESKTOP\DISTRESS.lnk"
  Delete "$DESKTOP\MHDDOS_PROXY_CONFIG.lnk"

  ;Remove all registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}"
  DeleteRegKey HKLM "Software\${PRODUCT}"

  ;Delete the installation directory + all files in it
  ;Add 'RMDir /r "$INSTDIR\folder\*.*"' for every folder you have added additionaly
  RMDir /r "$INSTDIR\*.*"
  RMDir "$INSTDIR"

  ;Delete Start Menu Shortcuts
  Delete "$SMPROGRAMS\${PRODUCT}\*.*"
  RmDir  "$SMPROGRAMS\${PRODUCT}"
  
nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionPath "$INSTDIR""'

SimpleFC::RemoveApplication "${DB1000N_DIR}\db1000n.exe"
nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "db1000n.exe""'

${If} ${RunningX64}
	SimpleFC::RemoveApplication "${MHDDOS_PROXY_DIR}\mhddos_proxy_win.exe"
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "mhddos_proxy_win.exe""'
	SimpleFC::RemoveApplication "${DISTRESS_DIR}\distress_x86_64-pc-windows-msvc.exe"
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "distress_x86_64-pc-windows-msvc.exe""'
${Else}
	SimpleFC::RemoveApplication "${MHDDOS_PROXY_DIR}\mhddos_proxy_win_x86.exe"
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "mhddos_proxy_win_x86.exe""'
	SimpleFC::RemoveApplication "${DISTRESS_DIR}\distress_i686-pc-windows-msvc.exe"
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "distress_i686-pc-windows-msvc.exe""'
${EndIf}

SectionEnd

