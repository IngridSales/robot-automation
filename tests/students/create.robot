*** Settings ***
Resource                            ${EXECDIR}/resources/base.robot

Suite Setup                         Start Admin Session
Test Teardown                       Take Screenshot

*** Test Cases ***
Cenário: Novo Aluno

    &{student}                      Create Dictionary               name=Floriano Silva       email=floriano@gmail.com        age=56      weight=77       feet_tall=1.73

    Remove Student                  ${student.email}
    Go To Students
    Go To Form Students
    New Student                     ${student}
    Wait For Toast                  Aluno cadastrado com sucesso.
    [Teardown]                      Thinking and Screenshot         2
Cenário: Não deve permitir email duplicado
    
    &{student}                      Create Dictionary               name=Maria Isabel Silva       email=bebelsilva@gmail.com        age=56      weight=77       feet_tall=1.73

    Insert Student                  ${student}
    Go To Students
    Go To Form Students
    New Student                     ${student}
    Wait For Toast                  Email já existe no sistema.
    [Teardown]                      Thinking and Screenshot         2

Cenário: Todos os campos devem ser obrigatórios
    
    @{expected_alerts}              Set Variable                    Nome é obrigatório      O e-mail é obrigatório      idade é obrigatória     o peso é obrigatório        a Altura é obrigatória
    @{got_alerts}                   Create List
    Go To Students
    Go To Form Students
    Submit Form

        FOR     ${index}            IN RANGE        1       6
            ${span}                 Get Required Alerts             ${index}
            Append To List          ${got_alerts}                   ${span}
        END
    Log                             ${expected_alerts}
    Log                             ${got_alerts}
    Lists Should Be Equal           ${expected_alerts}              ${got_alerts}
    [Teardown]                      Thinking and Screenshot         2

Cenário: Validação dos campos numéricos
    
    [Template]                      Check Type Field On Student Form
    ${AGE_FIELD}                    number
    ${WEIGHT_FIELD}                 number
    ${FEET_TALL_FIELD}              number

Cenário: Validar campo do tipo email

    [Template]                      Check Type Field On Student Form
    ${EMAIL_FIELD}                  email

Cenário: Menor de 14 anos não pode fazer cadastro

    &{student}                      Create Dictionary               name=Arthur Silva       email=tucosilva@gmail.com        age=13      weight=77       feet_tall=1.73

    Remove student                  ${student.email}
    Go To Students
    Go To Form Students
    New Student                     ${student}
    Get Span                        A idade
   
    [Teardown]                      Thinking and Screenshot         2
    
Cenário: Maior de 150 anos não pode fazer cadastro
    &{student}                      Create Dictionary               name=Mendonça       email=mendoncinha@gmail.com        age=151      weight=77       feet_tall=1.73

    Remove student                  ${student.email}
    Go To Students
    Go To Form Students
    New Student                     ${student}
    Get Span                        A idade
   
    [Teardown]                      Thinking and Screenshot         2

Cenário: Email inválido

    &{student}                      Create Dictionary               name=Irene Silva       email=irene$gmail.com        age=13      weight=77       feet_tall=1.73 
    
    Remove student                  ${student.email}
    Go To Students
    Go To Form Students
    New Student                     ${student}
    Get Span                        Informe um
    [Teardown]                      Thinking and Screenshot         2