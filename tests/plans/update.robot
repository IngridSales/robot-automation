*** Settings ***
Documentation                       Atualizar planos
Resource                            ${EXECDIR}/resources/base.robot
Suite Setup                         Start Admin Session
Test Teardown                       Take Screenshot

*** Test Case ***
Cenario: Atualizar um plano
   
    ${fixture}                      Get JSON                        plans-update.json
    ${planob1}                      Set Variable                    ${fixture['before']}
    ${planob2}                      Set Variable                    ${fixture['after']}

    Remove Plan                     ${planob1['title']}
    Remove Plan                     ${planob2['title']}
    Insert Plan                     ${planob1}
    Go To Plans

    Search Plan By Title            ${planob1['title']}
    Go To Plan Update Form          ${planob1['title']}
    Update A Plan                   ${planob2}
    Wait For Toast                  Plano Atualizado com sucesso
    [Teardown]                      Thinking and Screenshot         2