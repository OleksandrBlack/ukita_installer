;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include "x64.nsh"
  !include "LogicLib.nsh"
  !include "FileFunc.nsh"
  !include "WinVer.nsh"
;--------------------------------
;General

  ;Properly display all languages
  Unicode true
  
  SetCompressor /SOLID lzma
  SetCompressorDictSize 64
  SetDatablockOptimize ON

  ;Define name of the product
  !define PRODUCT "UkITA Installer"
  !define PRODUCT_VERSION "2.0.0"
  !define INSTALLER_NAME "ukita_installer"
  !define UNINSTALLER_NAME "uninstall"
  
  BrandingText "${PRODUCT} ${PRODUCT_VERSION}"
  
  !define MHDDOS_PROXY_SRC "https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git"
  
  !define MHDDOS_PROXY_DIR "$INSTDIR\mhddos_proxy"
  
  ;!define MHDDOS_PROXY_BETA_DIR "$INSTDIR\mhddos_proxy_beta"
  
  !define DB1000N_DIR "$INSTDIR\db1000n"
  
  !define DISTRESS_DIR "$INSTDIR\distress"
  
  !define PYTHON_DIR "$INSTDIR\python"
  
  !define GIT_DIR "$INSTDIR\git\git"

  ;Installer Version Information
  VIAddVersionKey "ProductName" "${PRODUCT}"
  VIAddVersionKey "CompanyName" "IT ARMY of Ukraine"
  VIAddVersionKey "LegalCopyright" "Copyright ©2022 UA ItArmy Installer"
  VIAddVersionKey "FileDescription" "UA ItArmy Installer"
  VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
  VIProductVersion "${PRODUCT_VERSION}.0"

  ;Define the main name of the installer
  Name "${PRODUCT}"

  ;Define the directory where the installer should be saved
  OutFile "output\${INSTALLER_NAME}.exe"



  # set to default here, override in .onInit if on 64bit
  InstallDir "$APPDATA\${INSTALLER_NAME}"


  ;Request rights if you want to install the program to program files
  RequestExecutionLevel admin

  ;Properly display all languages
  Unicode true

  ;Show 'console' in installer and uninstaller
  ShowInstDetails "show"
  ShowUninstDetails "show"

  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "Software\${PRODUCT}" ""


;--------------------------------
;Interface Settings

  ;Show warning if user wants to abort
  !define MUI_ABORTWARNING

  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

  ;Use optional a custom icon:
  !define MUI_ICON "resources\itarmy.ico" # for the Installer
  !define MUI_UNICON "resources\icon_uninstaller.ico" # for the later created UnInstaller

  ;Use optional a custom picture for the 'Welcome' and 'Finish' page:
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_HEADERIMAGE_BITMAP "resources\headerimage-r.bmp"
  !define MUI_HEADERIMAGE_UNBITMAP "resources\headerimage-uninstall-r.bmp"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "resources\welcomefinishimage.bmp"  # for the Installer
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "resources\unwelcomefinishimage.bmp"  # for the later created UnInstaller

  ;Optional no descripton for all components
  !define MUI_COMPONENTSPAGE_NODESC


;--------------------------------
;Pages
  ;For the installer
  !insertmacro MUI_PAGE_WELCOME # simply remove this and other pages if you don't want it
  
  Page Custom win7_info
  
  !insertmacro MUI_PAGE_LICENSE "LICENSE" # link to an ANSI encoded license file
  !insertmacro MUI_PAGE_COMPONENTS # remove if you don't want to list components
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES

  !define MUI_PAGE_CUSTOMFUNCTION_SHOW ShowFinishCheckbox
  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE OpenFinishLink

  !insertmacro MUI_PAGE_FINISH

  ;For the uninstaller
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH