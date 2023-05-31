*** Settings ***
Documentation                       Busca de planos
Resource                            ${EXECDIR}/resources/base.robot
Suite Setup                         Start Admin Session
Test Teardown                       Take Screenshot

*** Test Case ***
Cenario: Busca planos por um único termo
    
    ${fixture}                      Get JSON                        plans-search.json
    ${plans}                        Set Variable                    ${fixture['plans']}
    ${word}                         Set Variable                    ${fixture['word']}
    ${total}                        Set Variable                    ${fixture['total']}

    Remove Plan                         ${word}
    
    FOR     ${item}         IN          @{plans}
        Insert Plan                     ${item}
    END

    Go To Plans
    Search Plan By Title                ${word}

    FOR     ${item}         IN          @{plans}
        Plan Title Should Be Visible    ${item['title']}
    END

    Total Items Should Be               ${total}

Cenário: Busca exata
    
    &{plan}                         Create Dictionary               title=Plano L       duration=12     price=10.00          total=${EMPTY}

    Insert Plan                     ${plan}
    Go To Plans
    Search Plan By Title            ${plan.title}
    Plan Title Should Be Visible    ${plan.title}
    [Teardown]                      Thinking and Screenshot         2

Cenário: Registro não encontrado
    Go To Plans
    Get Register Not Found         Plano Doidão 
    [Teardown]                     Thinking and Screenshot         2