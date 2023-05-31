*** Settings ***
Documentation                           Ações do menu superior de navegação

*** Keywords ***
Go To Students
    Click                               xpath=//a[text()="ALUNOS"]
    Wait For Elements State             h1 >> text=Gestão de Alunos         visible         5

User Should Be Logged In
    [Arguments]                         ${user_name}
    Get Text                            css=aside strong                    should be       ${user_name}

Submit Form
    Click                               xpath=//button[text()="Salvar"]

Go To Plans
    Click                               xpath=//a[text()="PLANOS"]
    Wait For Elements State             h1 >> text=Gestão de Planos         visible         5