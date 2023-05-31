*** Settings ***
Documentation                       Base do Projeto

Library                             Browser
Library                             OperatingSystem
Library                             Collections
Library                             String
Library                             libs/library.py
Resource                            ${EXECDIR}/resources/actions/login.robot
Resource                            ${EXECDIR}/resources/actions/student.robot
Resource                            ${EXECDIR}/resources/actions/nav.robot
Resource                            ${EXECDIR}/resources/actions/componentes.robot
Resource                            ${EXECDIR}/resources/actions/plans.robot

*** Variables ***
${NAME_FIELD}                       css=input[name=name]
${EMAIL_FIELD}                      css=input[name=email]
${AGE_FIELD}                        css=input[name=age]
${WEIGHT_FIELD}                     css=input[name=weight]
${FEET_TALL_FIELD}                  css=input[name=feet_tall]

${TITLE_FIELD}                      css=input[name="title"]           
${DURATION_FIELD}                   css=input[name="duration"]        
${PRICE_FIELD}                      css=input[name="price"]
${TOTAL_FIELD}                      css=input[name=total]  

*** Keywords ***
Start Session
    New Browser                     chromium        true
    New Page                        about:blank

Start Admin Session
    Start Session
    Go To Page
    Acceso                          admin@bodytest.com          pwd123
    User Should Be Logged In        Administrador

Get JSON
    [Arguments]                     ${file_name}
    ${file}                         Get File                    ${EXECDIR}/resources/fixtures/${file_name}
    ${json_object}                  Evaluate                    json.loads($file)           json
    [return]                        ${json_object}
