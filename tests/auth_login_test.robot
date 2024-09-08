*** Settings ***
Library           OperatingSystem
Library           Collections
Resource          ../pages/auth_logic_page.resource
Resource          ../keywords/custom_keywords.robot

*** Test Cases ***
Verify successful login with valid credentials
    [Documentation]    Verify that the API returns success with valid login credentials
    [Tags]              login
    ${payload}=        setup testdata   data=auth       key=valid_credentials
    Post Auth Request
    ...             payload=${payload}
    Check Valid login Schema     data=auth       test=valid


Verify authetication failure with wrong email
    [Documentation]    Verify that the API returns an error with invalid login credentials
    [Tags]              login
    ${payload}=        setup valid emaildata   data=auth       key=invalid_credentials
    Post Auth Request
    ...             payload=${payload}
    Check Login with Invalid Credentials    data=auth       test=valid

Verify authetication failure with wrong password
    [Documentation]    Verify that the API returns a validation error for wrong login password
    [Tags]              login
    ${payload}=        setup testdata   data=auth       key=short_password
    Post Auth Request
    ...             payload=${payload}
    Check Login with Short Password    data=auth       test=valid

