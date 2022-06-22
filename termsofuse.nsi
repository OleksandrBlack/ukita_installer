Var TermsPage
Var TermsPage.Terms
Var TermsPage.Firewall

Function Page_TermsOfUse

    nsDialogs::Create 1018
    Pop $TermsPage
    ${If} $TermsPage == error
        Abort
    ${EndIf}

    !insertmacro MUI_HEADER_TEXT $(terms_title) $(terms_subtitle)
    SetCtlColors $TermsPage 0x000000 0xF0F0F0

    ${NSD_CreateLabel} 20 15 423 150  $(terms_terms)
    Pop $TermsPage.Terms
    EnableWindow $TermsPage.Terms 1
    ShowWindow $TermsPage.Terms ${SW_SHOW}
    SetCtlColors $TermsPage.Terms 0x000000 0xF0F0F0
	
    ${NSD_CreateLabel} 20 165 423 50  $(terms_firewall)
    Pop $TermsPage.Firewall
    EnableWindow $TermsPage.Firewall 1
    ShowWindow $TermsPage.Firewall ${SW_SHOW}
    SetCtlColors $TermsPage.Firewall 0x000000 0xF0F0F0

    nsDialogs::Show
FunctionEnd
