nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_python_in""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_git_in""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_db1000n_in""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_distress_in""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_mhddos_in""'

nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_python_out""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_git_out""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_db1000n_out""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_distress_out""'
nsExec::Exec 'cmd /c "netsh advfirewall firewall Delete rule name="itarmy_mhddos_out""'

nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionPath "$INSTDIR""'
nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "python.exe""'
nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "git.exe""'
nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "db1000n.exe""'
${If} ${RunningX64}
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "mhddos_proxy_win.exe""'
${Else}
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "mhddos_proxy_win_x86.exe""'
${EndIf}

${If} ${RunningX64}
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "mhddos_proxy_win.exe""'
${Else}
	nsExec::Exec 'cmd /c "powershell -exec bypass -Command Remove-MpPreference -ExclusionProcess "mhddos_proxy_win_x86.exe""'
${EndIf}