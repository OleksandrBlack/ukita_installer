${If} ${RunningX64}
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_mhddos_in" dir=in action=allow program="${MHDDOS_PROXY_DIR}\mhddos_proxy_win.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_mhddos_out" dir=out action=allow program="${MHDDOS_PROXY_DIR}\mhddos_proxy_win.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "mhddos_proxy_win.exe""'
${Else}
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_mhddos_in" dir=in action=allow program="${MHDDOS_PROXY_DIR}\mhddos_proxy_win_x86.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_mhddos_out" dir=out action=allow program="${MHDDOS_PROXY_DIR}\mhddos_proxy_win_x86.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "mhddos_proxy_win_x86.exe""'
${EndIf}