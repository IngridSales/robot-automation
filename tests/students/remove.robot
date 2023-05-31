*** Settings ***
Documentation                           Remover alunos
Resource                                ${EXECDIR}/resources/base.robot
Suite Setup                             Start Admin Session
Test Teardown                           Take Screenshot

*** Test Case ***
Cenário: Remover aluno cadastrado

    &{student}                          Create Dictionary               name=Lineu Silva       email=lineuzinho@gmail.com        age=56      weight=77       feet_tall=1.73

    Insert Student                      ${student}
    Go To Students
    Search Student By Name              ${student["name"]}
    Student Name Should Be Visible      ${student["name"]}
    Confirm Remove                      Aluno removido com sucesso.
    [Teardown]                          Thinking and Screenshot         2
    
Cenário: Desistir da exclusão

    &{student}                          Create Dictionary               name=Agostinho Carrara       email=carrarataxioutaxicarrara@aindanaodecidimos.com        age=46      weight=70       feet_tall=1.73

    Insert Student                      ${student}
    Go To Students
    Search Student By Name              ${student["name"]}
    Student Name Should Be Visible      ${student["name"]}
    Cancel Remove        
    [Teardown]                          Thinking and Screenshot         2