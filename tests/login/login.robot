*** Settings ***
Resource                            ${EXECDIR}/resources/base.robot
Suite Setup                         Start Session
Test Teardown                       Take Screenshot

*** Test Cases ***
Cenário: Email não cadastrado

    Go To Page
    Start Admin Session             isalesmartins93@gmail.com           123123
    Wait For Toast
    ...                             Usuário e/ou senha inválidos.
    [Teardown]                      Thinking and Screenshot             2
    
Cenário: Login do admin
    
    Go To Page
    Start Admin Session             admin@bodytest.com                  pwd123
    Get Text                        css=div strong      contains        Administrador
    [Teardown]                      Clear Storage e Screenshot

Cenário: Os campos devem ser obrigatórios

    Go To Page
    Start Admin Session             ${EMPTY}        ${EMPTY}
    Span Campos Obrigatórios
    ...                             A senha é obrigatória
    ...                             O e-mail é obrigatório

Cenário: O email deve ser obrigatório

    Go To Page
    Start Admin Session             ${EMPTY}       pwd123
    Click                           css=button >> text=Entrar
    Buscar Span Email Inválido      O e-mail é obrigatório

Cenário: A senha deve ser obrigatória

    Go To Page
    Start Admin Session             admin@bodytest.com                  ${EMPTY}
    Click                           css=button >> text=Entrar
    Buscar Span Senha Inválida      A senha é obrigatória

Cenário: Email inválido

    Go To Page
    Start Admin Session             admin%bodytest.com                  123123
    Buscar Span Email Inválido      Informe um e-mail válido

Cenário: Senha inválida

    Go To Page
    Start Admin Session             admin@bodytest.com                  pwd
    Wait For Toast
    ...                             Usuário e/ou senha inválidos.
    [Teardown]                      Thinking and Screenshot             2
