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
  
	;Delete firewall&&defender rule
  	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_python_in""'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_git_in""'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_db1000n_in""'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_distress_in""'

  	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_python_out""'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_git_out""'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_db1000n_out""'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_distress_out""'
	
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "python.exe""'
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "git.exe""'
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "db1000n.exe""'
	${If} ${RunningX64}
		nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "distress_x86_64-pc-windows-msvc.exe""'
	${Else}
		nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "distress_i686-pc-windows-msvc.exe""'
	${EndIf}

SectionEnd

