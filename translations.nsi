; nsis translations

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "SimpChinese"
;!insertmacro MUI_LANGUAGE "Polish"

;Installer/Uninstaller translations
!addincludedir translations

;The languages should be in alphabetical order
!include english.nsi
!include dutch.nsi
!include german.nsi
!include italian.nsi
!include japanese.nsi
!include lithuanian.nsi
!include spanish.nsi
!include ukrainian.nsi
!include simpchinese.nsi
;!include polish.nsi