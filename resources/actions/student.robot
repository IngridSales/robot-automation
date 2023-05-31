*** Settings ***
Documentation                           Ações do projeto - Alunos

*** Keywords ***
Get Register Not Found

    [Arguments]                         ${name}
    Fill Text                           css=input[placeholder^="Buscar"]         ${name}
    Get Text                            xpath=//div[text()="Nenhum registro encontrado."]

Confirm Remove
    [Arguments]                         ${txt_expect}
    Click                               xpath=//span[text()=" Apagar"]
    Get Text                            xpath=//div//h2[text()="Você está certo disso?"]
    Click                               xpath=//div//button[text()="SIM, pode apagar!"]
    Wait For Toast                      ${txt_expect}

Cancel Remove

    Click                               xpath=//span[text()=" Apagar"]
    Get Text                            xpath=//div//h2[text()="Você está certo disso?"]
    Click                               xpath=//div//button[text()="NÃO"]

Go To Form Students

    Click                               xpath=//a[@href="/alunos/new"]
    Wait For Elements State             h1 >> text=Novo aluno           visible         5

New Student

    [Arguments]                         ${student}        
    Fill Text                           css=input[name="name"]          ${student.name}
    Fill Text                           css=input[name=email]           ${student.email}
    Fill Text                           css=input[name=age]             ${student.age}
    Fill Text                           css=input[name=weight]          ${student.weight}
    Fill Text                           css=input[name=feet_tall]       ${student.feet_tall}
    Submit Form

Get Required Alerts
    [Arguments]                         ${index}
    ${span}                             Get Text            xpath=(//form//span)[${index}]
    [return]                            ${span}

Search Student By Name
    [Arguments]                         ${name}
    Fill Text                           css=input[placeholder="Buscar aluno"]           ${name}

Go To Student Update Form
    [Arguments]                         ${email}
    Click                               xpath=//td[contains(text(), "${email}")]/..//a[@class="edit"]
    Wait For Elements State             css=h1 >> text=Edição de aluno              visible             5

Update A Student
    [Arguments]                         ${student}        
    Fill Text                           ${NAME_FIELD}            ${student['name']}
    Fill Text                           ${EMAIL_FIELD}           ${student['email']}
    Fill Text                           ${AGE_FIELD}             ${student['age']}
    Fill Text                           ${WEIGHT_FIELD}          ${student['weight']}
    Fill Text                           ${FEET_TALL_FIELD}       ${student['feet_tall']}
    Submit Form

Student Name Should Be Visible
    [Arguments]                         ${name}
    Wait For Elements State             css=table tbody tr >> text=${name}          Visible             5