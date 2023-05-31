*** Settings ***
Documentation                           Ações do projeto - Login

*** Keywords ***
Go To Page 
    Go To                               https://bodytest-web-drakke.herokuapp.com/
Acceso
    [Arguments]                         ${email}        ${pass}
    Fill Text                           xpath=//input[@name="email"]            ${email}
    Fill Text                           xpath=//input[@name="password"]         ${pass}
    Click                               css=button >> text=Entrar

Buscar Span Email Inválido
    [Arguments]                         ${span_email_inv}
    Get Text                            css=span        contains                ${span_email_inv}

Buscar Span Senha Inválida
    [Arguments]                         ${span_senha_inv}           
    Get Text                            css=span        contains                ${span_senha_inv}

Span Campos Obrigatórios
    [Arguments]                         ${span_email_obr}       ${span_senha_obr}
    Get Text                            css=span >> text=${span_email_obr}
    Get Text                            css=span >> text=${span_senha_obr}

    ###testar mais tarde
    #Get Span 
    #[Arguments]                        ${msg}
    #${element}      Set Variable       xpath=//span[text()^="${msg}"]