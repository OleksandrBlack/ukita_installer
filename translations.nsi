; nsis translations

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "TradChinese"

;Installer/Uninstaller translations
!addincludedir translations

;The languages should be in alphabetical order
!include English.nsi
!include Dutch.nsi
!include German.nsi
!include Italian.nsi
!include Japanese.nsi
!include Lithuanian.nsi
!include Polish.nsi
!include Spanish.nsi
!include Ukrainian.nsi
!include TradChinese.nsi
