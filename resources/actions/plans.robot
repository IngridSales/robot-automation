*** Settings ***
Documentation                           Ações do projeto - Planos

*** Keywords ***
Go To Form Plans
    Click                               xpath=//a[@href="/planos/new"]
    Wait For Elements State             h1 >> text=Novo plano           visible         5

New Plan
    [Arguments]                         ${plan}        
    Fill Text                           ${TITLE_FIELD}                  ${plan.title}
    Fill Text                           ${DURATION_FIELD}               ${plan.duration}
    Fill Text                           ${PRICE_FIELD}                  ${plan.price}
    Submit Form 

Search Plan By Title
    [Arguments]                         ${title}
    Fill Text                           css=input[placeholder="Buscar plano"]           ${title}

Update A Plan
    [Arguments]                         ${plan}                
    Fill Text                           ${TITLE_FIELD}              ${plan["title"]}         
    Fill Text                           ${DURATION_FIELD}           ${plan["duration"]}
    Fill Text                           ${PRICE_FIELD}              ${plan["price"]}
    Submit Form

Go To Plan Update Form
    [Arguments]                         ${title}
    Click                               xpath=//td[text()="Plano B1"]/..//a
    Wait For Elements State             css=h1 >> text=Edição de plano                  visible             3

Total Plan Should Be
    [Arguments]                         ${total}
    Get Attribute                       ${TOTAL_FIELD}          value               ==              ${total}    

Plan Title Should Be Visible
    [Arguments]                         ${title}
    Wait For Elements State             css=table tbody tr >> text=${title}              Visible            5