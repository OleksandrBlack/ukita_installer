;Nsis translations

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "Ukrainian"

;Installer/Uninstaller translations
!addincludedir translations

;The languages should be in alphabetical order
!include english.nsi
!include russian.nsi
!include spanish.nsi
!include ukrainian.nsi
