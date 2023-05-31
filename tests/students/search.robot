*** Settings ***
Documentation                           Busca de alunos
Resource                                ${EXECDIR}/resources/base.robot
Suite Setup                             Start Admin Session
Test Teardown                           Take Screenshot

*** Test Case ***
Cenario: Busca alunos por um único termo
    ${fixture}                          Get JSON                        students-search.json
    ${students}                         Set Variable                    ${fixture['students']}
    ${word}                             Set Variable                    ${fixture['word']}
    ${total}                            Set Variable                    ${fixture['total']}

    Remove Student By Name                  ${word}
    
    FOR     ${item}         IN              @{students}
        Insert Student                      ${item}
    END

    Go To Students
    Search Student By Name                  ${word}

    FOR     ${item}         IN              @{students}
        Student Name Should Be Visible      ${item['name']}
    END

    Total Items Should Be               ${total}

Cenário: Busca exata
    
    &{student}                          Create Dictionary               name=Doutor Abelardo       email=drabelardo@gmail.com        age=56      weight=77       feet_tall=1.73

    Insert Student                      ${student}
    Go To Students
    Search Student By Name              ${student["name"]}
    Student Name Should Be Visible      ${student["name"]}
    [Teardown]                          Thinking and Screenshot         2

Cenário: Registro não encontrado
    
    Go To Students
    Get Register Not Found              Abigail 
    [Teardown]                          Thinking and Screenshot         2
