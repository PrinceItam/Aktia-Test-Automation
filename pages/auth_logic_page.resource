*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem

*** Variables ***
${BASE_URL}       https://www.quickpickdeal.com/api/auth/login
${HEADERS}              {"Content-Type": "application/json"}

*** Keywords ***
Create Auth Session
    [Arguments]    ${alias}
    Create Session    ${alias}    ${BASE_URL}  headers=${HEADERS}  verify=True

Post Auth Request
    [Arguments]     ${payload}     ${url}=${BASE_URL}
    Establish Post Request       url=${BASE_URL}      payload=${payload}
