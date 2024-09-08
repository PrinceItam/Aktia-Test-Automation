*** Settings ***
Library           OperatingSystem
Library           Collections
Resource          ../pages/auth_registration_page.resource
Resource          ../keywords/custom_keywords.robot

*** Test Cases ***
Valid User Registration
    [Documentation]    Verify that the API returns success with valid credentials
    [Tags]              signup
    ${payload}=        setup testdata  data=registration       key=valid_user_details
    Post Auth Request
    ...             payload=${payload}

    Check Valid User Registration Schema  data=registration  test=email

Verify Invalid Password fails authetication
    [Documentation]    Verify that the API returns 400 status
    [Tags]             signup
    ${payload}=        setup testdata  data=registration       key=invalid_user_pwd
    Post Auth Request
    ...             payload=${payload}
    Check Invalid Password Schema  data=registration  test=email

Verify mismatch passwords fail authetication
    [Documentation]    Verify that the API returns 400 status
    [Tags]              signup
    ${payload}=        setup testdata  data=registration       key=pwd_mismatch
    Post Auth Request
    ...             payload=${payload}
    Check Mismatched Password Schema    data=registration  test=email

Verify user cannot regsiter with a used email
    [Documentation]    Verify that the API returns 400 status
    [Tags]              signup
    ${payload}=        setup testdata  data=registration       key=already_used_email
    Post Auth Request
    ...             payload=${payload}
    Check Same Email Schemna    data=registration  test=email

Verify user cannot regsiter with an invalid email
    [Documentation]    Verify that the API returns 400 status
    [Tags]              signup
    ${payload}=        setup testdata  data=registration       key=invalid_user_email
    Post Auth Request
    ...             payload=${payload}
    Check Invalid Email Schemna   data=registration  test=email
