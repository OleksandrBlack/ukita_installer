; nsis translations

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "Polish"

;Installer/Uninstaller translations
!addincludedir translations

;The languages should be in alphabetical order
!include english.nsi
!include german.nsi
!include lithuanian.nsi
!include spanish.nsi
!include ukrainian.nsi
!include polish_new.nsi