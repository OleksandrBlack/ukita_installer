sudo apt-get install -y nsis unzip

# db1000n
wget -q -P requirements/db1000n/x64/ https://github.com/arriven/db1000n/releases/latest/download/db1000n_windows_amd64.zip
cd requirements/db1000n/x64 && unzip * && cd -
wget -q -P requirements/db1000n/x86/ https://github.com/arriven/db1000n/releases/latest/download/db1000n_windows_386.zip
cd requirements/db1000n/x86 && unzip * && cd -

# Distress
wget -q -P requirements/distress/x64/ https://github.com/Yneth/distress-releases/releases/latest/download/distress_x86_64-pc-windows-msvc.exe
wget -q -P requirements/distress/x86/ https://github.com/Yneth/distress-releases/releases/latest/download/distress_i686-pc-windows-msvc.exe

# Make build
mkdir output
makensis ukita_installer.nsi
