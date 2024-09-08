*** Settings ***
Library           Collections
Library           OperatingSystem
Library           RequestsLibrary
Library           ../resources/StartConnection.py

*** Keywords ***
setup testdata
   [Arguments]          ${data}     ${key}
   ${payload}           prepare payload
   ...                  path=test_data/${data}/${data}_data.json
   ...                  key=${key}
   RETURN               ${payload}


Check Valid login Schema
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/auth/auth_valid_schema.json
    Validate Schema      ${expected}      ${content}

Check Login with Invalid Credentials
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/auth/auth_invalid_schema.json
    Validate Schema      ${expected}      ${content}

Check Login with Short Password
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/auth/auth_short_pwd_schema.json
    Validate Schema      ${expected}      ${content}

Check Valid User Registration Schema
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/registration/auth_valid_registration_schema.json
     Validate Schema      ${expected}      ${content}

Check Invalid Password Schema
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/registration/auth_wrong_pwd_schema.json
     Validate Schema      ${expected}      ${content}

Check Mismatched Password Schema
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/registration/auth_mismatch_pwd_schema.json
     Validate Schema      ${expected}      ${content}

Check Same Email Schemna
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/registration/auth_used_email_schema.json
     Validate Schema      ${expected}      ${content}

Check Invalid Email Schemna
    [Arguments]          ${data}        ${test}
    set test variable    ${status_code}    ${RESPONSE.status_code}
    ${content}      convert json to dictionary
    ${expected}     convert json to dictionary      file=test_data/registration/auth_invalid_email_schema.json
     Validate Schema      ${expected}      ${content}