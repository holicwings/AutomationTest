*** Settings ***
Documentation      Sample Test Script For Google Site
...                File Version 1.0
Resource           ../Resources/RobotFunctions/commons.robot
Test Teardown      Close All Browsers

*** Variables ***
${testURL}          https://automationinterface1.front.staging.optimy.net/en/
${userName}         optimyautomationtester@gmail.com
${userPassword}     yRMhojb7
${filePath}         //TEST_FUNCTIONAL//Resources//TestData//optimyPic.png
@{toolsList}        Java    Cucumber    Robot Framework

*** Test Cases ***
OptimyTest.TC01 - Verify If New Application Is Successfully Submited
    GIVEN User Login To Application
    WHEN User Submits A New Application
    # THEN New Application Is Successfully Submited

*** Keywords ***
User Login To Application
    Setup Environment and Open Browser    ${testURL}
    Wait Until Element Is Visible    css:button#cookie-allow-necessary-button    10
    Click Element    css:button#cookie-allow-necessary-button
    Wait Until Element Is Not Visible    css:button#cookie-allow-necessary-button    10
    Login To App    ${userName}    ${userPassword}
    
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

User Submits A New Application
    Click Element When Clickable   css:a.btn-primary
    Wait Until Element is Visible    css:div.page-main__content-wrapper h1
    ${h1Text}    Get Text    css:div.page-main__content-wrapper h1
    ${isVisible}    Run Keyword And Return Status    Should Be Equal    ${h1Text}    Continue with the submission of an application?
    Run Keyword If    ${isVisible} == ${True}    Submit New Application
    Input Field Data    First name    firstNameSample
    Input Field Data    Last name     lastNameSample
    Input Field Data    Extension     extensionSample
    Input Address    Sample Address
    Input Field Data    Select postal code     1000
    Select From List By Label    css:select.locationCountry.custom-select    Philippines
    Upload Photo
    Select Gender    Female
    Select From List By Label    css:select[aria-label\="Select a role you're applying for"]    Automation tester
    FOR    ${element}    IN    @{toolsList}
        Scroll Element Into View    css:label[aria-label\="${element}"]
        Click Element    css:label[aria-label\="${element}"]
    END
    Select Frame    css:iframe[title^\='Editor']
    Input Text    css:body[role="textbox"]    Sample Text
    Sleep    10sec

Submit New Application
    Scroll Element Into View    css:a[href^\='/en/project/new/'].btn-outline-primary
    Click Element When Clickable    css:a[href^\='/en/project/new/'].btn-outline-primary
    Wait Until Element Is Visible    css:a.projectStepsLink

New Application Is Successfully Submited


Input Field Data
    [Arguments]    ${fieldName}    ${fieldValue}
    Wait Until Element Is Visible    css:input[aria-label\="${fieldName}"]
    Input Text    css:input[aria-label\="${fieldName}"]    ${fieldValue}

Input Address
    [Arguments]    ${fieldValue}
    Wait Until Element Is Visible    css:div.field textarea
    # Input Text    css:textarea[aria-label\="Unit no/House no, Street"]    ${fieldValue}
    Input Text    css:div.field textarea    ${fieldValue}

Upload Photo
    Choose File    css:input[name\="Filedata"][type="file"]   ${EXECDIR}/${filePath}

Select Gender
    [Arguments]    ${gender}
    Wait Until ELement is visible    css:label.custom-control[aria-label\="${gender}"]
    Click Element    css:label.custom-control[aria-label\="${gender}"]