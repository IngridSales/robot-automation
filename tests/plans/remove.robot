*** Settings ***
Documentation                       Remover planos
Resource                            ${EXECDIR}/resources/base.robot
Suite Setup                         Start Admin Session
Test Teardown                       Take Screenshot

*** Test Case *** 
Cenário: Remover plano cadastrado
    &{plan}                         Create Dictionary               title=Plano A3       duration=4         price=10.00              
   
    Insert Plan                     ${plan}
    Go To Plans
    Search Plan By Title            ${plan.title}
    Plan Title Should Be Visible    ${plan.title}
    Confirm Remove                  Plano removido com sucesso
    [Teardown]                      Thinking and Screenshot         2

Cenário: Desistir da exclusão 
    &{plan}                         Create Dictionary               title=Plano B3       duration=4         price=10.00              

    Insert Plan                     ${plan}
    Go To Plans
    Search Plan By Title            ${plan.title}
    Plan Title Should Be Visible    ${plan.title}
    Cancel Remove        
    [Teardown]                      Thinking and Screenshot         2
    
