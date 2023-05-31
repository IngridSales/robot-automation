*** Settings ***
Documentation                       Remover alunos
Resource                            ${EXECDIR}/resources/base.robot
Suite Setup                         Start Session
Test Teardown                       Take Screenshot

*** Test Case ***
Cenário: Novo plano
   
    &{plan}                         Create Dictionary               title=Plano A       duration=12         price=10,00              total=${EMPTY}

    Remove Plan                     ${plan.title}
    Go To Plans             
    Go To Form Plans        
    New Plan                        ${plan}
    Wait For Toast                  Plano cadastrado com sucesso
    [Teardown]                      Thinking and Screenshot         2

Cenário: Validação dos campos numericos
    
    [Template]                      Check Type Field On Plans Form
    ${PRICE_FIELD}                  number

Cenário: Tiulo e Duração devem ser obrigatórios
  
    @{alerts}                       Set Variable                    Informe o título do plano       Informe a duração do plano em meses         
    @{got_alerts}                   Create List
    Go To Plans             
    Go To Form Plans
    Submit Form

        FOR     ${index}            IN RANGE        1       3
            ${span}                 Get Required Alerts             ${index}
            Append To List          ${got_alerts}                   ${span}
        END
    Log                             ${alerts}
    Log                             ${got_alerts}
    Lists Should Be Equal           ${alerts}                       ${got_alerts}
    [Teardown]                      Thinking and Screenshot         2

Cenário: A duração do plano deve ser no máximo 60 meses
    
    &{plan}                         Create Dictionary               title=Plano B       duration=61         price=10,00              total=${EMPTY}

    Remove Plan                     ${plan.title}
    Go To Plans             
    Go To Form Plans        
    New Plan                        ${plan}
    Get Span                        A duração dever ser no máximo 60 meses
    [Teardown]                      Thinking and Screenshot         2

Cenário: Calcular o preço total do plano

    &{plan}                         Create Dictionary               title=Plano C       duration=4         price=10,00            total=R$ 40,00

    Remove Plan                     ${plan.title}
    Go To Plans             
    Go To Form Plans        
    New Plan                        ${plan}
    Total Plan Should Be            ${plan.total}
    

Cenário: O preço mensal deve ser menor que 100.000.000,00
    
    &{plan}                         Create Dictionary               title=Plano D       duration=4         price=100.000.000,00              total=${EMPTY}

    Remove Plan                     ${plan.title}
    Go To Plans             
    Go To Form Plans        
    New Plan                        ${plan}
    Wait For Toast                  Erro cadastrar aluno!
    [Teardown]                      Thinking and Screenshot         2

Cenario: Campo Preço do Plano deve ser obrigatório e maior do que zero
    
    &{plan}                         Create Dictionary               title=Plano Louco       duration=12     price=${EMPTY}          total=${EMPTY}
    ${expected_alert}               Set Variable                    O preço é obrigatório
    Go To Plans
    Go To Form Plans
    New Plan                        ${plan}
    ${got_alert}                    Get Text                        xpath=//form//span
    Log                             ${expected_alert}
    Log                             ${got_alert}
    Should Be String                ${expected_alert}               ${got_alert}
    [Teardown]                      Thinking and Screenshot         2

Cenário: A duração do plano deve ser no minimo 1 mês
    
    &{plan}                         Create Dictionary               title=Plano F       duration=-1         price=10,00              total=${EMPTY}

    Remove Plan                     ${plan.title}
    Go To Plans             
    Go To Form Plans        
    New Plan                        ${plan}
    Get Span                        A duração dever ser no mínimo 1 mês
    [Teardown]                      Thinking and Screenshot         2

