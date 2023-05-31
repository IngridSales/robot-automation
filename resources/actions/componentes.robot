*** Settings ***
Documentation                           Ações de componentes genericos

*** Keywords ***
Wait For Toast
    [Arguments]                         ${txt_esperado}
    Log                                 ${txt_esperado}
    Wait For Elements State             css=.Toastify__toast-body >> text=${txt_esperado}       visible         3

Total Items Should Be
    [Arguments]                         ${number}
    ${element}                          Set Variable                css=#pagination .total
    Wait For Elements State             ${element}                  visible                     5
    Get Text                            ${element}                  ==                          Total: ${number}

Get Span   
    [Arguments]                         ${msg}
    Log                                 ${msg}
    ${element}      Set Variable        ${msg}
    

Check Type Field On Student Form

    [Arguments]                         ${element}      ${type}
    Go To Students
    Go To Form Students
    Field Should Be Type                ${element}      ${type}

Field Should Be Type

    [Arguments]                         ${element}      ${type}
    ${attr}         Get Attribute       ${element}      type

Check Type Field On Plans Form

    [Arguments]                         ${element}      ${type}
    Go To Plans
    Go To Form Plans
    Field Should Be Type                ${element}      ${type}

Clear Storage e Screenshot
    LocalStorage Clear
    Take Screenshot

Thinking and Screenshot
    [Arguments]                         ${timeout}
    Sleep                               ${timeout}
    Take Screenshot