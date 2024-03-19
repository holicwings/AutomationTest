*** Settings ***
Documentation   COMMON KEYWORDS USED FOR Optimy
...             File Version 1.0
Library         Collections
Library         RPA.Browser.Selenium
Resource        ../RobotLocators/commons.object.robot
Resource        ../RobotLocators/optimy.object.robot

*** Keywords ***
Allow Necessary Cookies Only
    Wait Until Element Is Visible    css:button#cookie-allow-necessary-button    10
    Click Element    css:button#cookie-allow-necessary-button
    Wait Until Element Is Not Visible    css:button#cookie-allow-necessary-button    10

Login To App
    [Arguments]    ${userName}    ${password}
    ${isLoginvisible}    Run Keyword And Return Status    Wait Until Element Is Visible    css:a.ml-auto    5
    Run Keyword If    ${isLoginvisible} == True    Click Element    css:a.ml-auto
    Wait Until Element Is Visible    css:#login-email    
    Input Text    css:#login-email       ${userName}
    Input Text    css:#login-password    ${password}
    Wait Until Element Is Enabled    css:form#login-form button[type\="submit"]
    Click Element    css:form#login-form button[type\="submit"]
    Wait Until Element Is Visible    css:span[data-original-title\="My account"]

Submit New Application
    Scroll Element Into View    css:a[href^\='/en/project/new/'].btn-outline-primary
    Click Element When Clickable    css:a[href^\='/en/project/new/'].btn-outline-primary
    Wait Until Element Is Visible    css:a.projectStepsLink

Input Field Data
    [Arguments]    ${fieldName}    ${fieldValue}
    Wait Until Element Is Visible    css:input[aria-label\="${fieldName}"]
    Input Text    css:input[aria-label\="${fieldName}"]    ${fieldValue}

Input Address
    [Arguments]    ${fieldValue}
    Wait Until Element Is Visible    css:div.field textarea
    Input Text    css:div.field textarea    ${fieldValue}

Upload Photo
    [Arguments]    ${filePath}
    Choose File    css:input[name\="Filedata"][type="file"]   ${EXECDIR}/${filePath}

Select Gender
    [Arguments]    ${gender}
    Wait Until ELement is visible    css:label.custom-control[aria-label\="${gender}"]
    Click Element    css:label.custom-control[aria-label\="${gender}"]

Field Data Is Validated
    [Arguments]    ${objectPath}    ${actualResult}
    ${actualText}    Get Text   ${objectPath}
    Should Be Equal    ${actualText}    ${actualResult}
