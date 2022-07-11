${If} ${RunningX64}
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_in" dir=in action=allow program="${DISTRESS_DIR}\distress_x86_64-pc-windows-msvc.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_out" dir=out action=allow program="${DISTRESS_DIR}\distress_x86_64-pc-windows-msvc.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "distress_x86_64-pc-windows-msvc.exe""'
${Else}
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_in" dir=in action=allow program="${DISTRESS_DIR}\distress_i686-pc-windows-msvc.exe" enable=yes"'
	nsExec::Exec 'cmd /c "netsh advfirewall firewall add rule name="itarmy_distress_out" dir=out action=allow program="${DISTRESS_DIR}\distress_i686-pc-windows-msvc.exe" enable=yes"'
	nsExec::Exec 'cmd /c "powershell -ExecutionPolicy Bypass -NoProfile -Command Add-MpPreference -ExclusionProcess "distress_i686-pc-windows-msvc.exe""'
${EndIf}