*** Settings ***
Documentation      Sample Test Script For Optimy Site
...                File Version 1.0
Resource           ../Resources/RobotFunctions/commons.robot
Resource           ../Resources/RobotFunctions/optimy.robot
Test Teardown      Close All Browsers

*** Variables ***
${testURL}          https://automationinterface1.front.staging.optimy.net/en/
${userName}         optimyautomationtester@gmail.com
${userPassword}     yRMhojb7

#User Data
${firstName}        firstNameSample
${lastName}         lastNameSample
${extension}        extensionSample
${address}          Sample Address
${postalCode}       1000
${country}          Philippines
${gender}           Female
${role}             Automation tester
${objective}        Sample Text Objective
${fileName}         optimyPic.png
${filePath}         //TEST_FUNCTIONAL//Resources//TestData//${fileName}
@{toolsList}        Java    Cucumber    Robot Framework

*** Test Cases ***
OptimyTest.TC01 - Verify If New Application Is Successfully Submited
    GIVEN User Login To Application
    WHEN User Submits A New Application
    THEN Input Data Is Validated Correctly
    AND New Application Is Successfully Submited

*** Keywords ***
User Login To Application
    Setup Environment and Open Browser    ${testURL}
    Allow Necessary Cookies Only
    Login To App    ${userName}    ${userPassword}

User Submits A New Application
    Click Element When Clickable   css:a.btn-primary
    Wait Until Element is Visible    css:div.page-main__content-wrapper h1
    ${h1Text}    Get Text    css:div.page-main__content-wrapper h1
    ${isVisible}    Run Keyword And Return Status    Should Be Equal    ${h1Text}    Continue with the submission of an application?
    Run Keyword If    ${isVisible} == ${True}    Submit New Application
    Input Field Data    First name    ${firstName}
    Input Field Data    Last name     ${lastName}
    Input Field Data    Extension     ${extension}
    Input Address    ${address}
    Input Field Data    Select postal code     ${postalCode}
    Wait Until Element Is Visible    css:ul.ui-menu a
    Click Element    css:ul.ui-menu a
    Select From List By Label    css:select.locationCountry.custom-select    ${country}
    Upload Photo    ${filePath}
    Select Gender    ${gender}
    Select From List By Label    css:select[aria-label\="Select a role you're applying for"]    ${role}
    FOR    ${element}    IN    @{toolsList}
        Scroll Element Into View    css:label[aria-label\="${element}"]
        Click Element    css:label[aria-label\="${element}"]
    END
    Wait Until Element Is Visible    css:iframe[title^\='Editor']
    Select Frame    css:iframe[title^\='Editor']
    Input Text    css:body[role="textbox"]    ${objective}
    Sleep    10sec
    Unselect Frame  
    Click Element When Visible    css:button#navButtonNext

New Application Is Successfully Submited
    Scroll Element Into View    css:div.d-none button#submitButton
    Click Element   css:div.d-none button#submitButton

    Wait Until Element Is Visible    css:div.text-success+h1
    ${successMessage}    Get Text    css:div.text-success+h1
    Should Be Equal    ${successMessage}    Thank you for submitting your project

Input Data Is Validated Correctly
    Wait Until Element Is Not Visible    css:button#navButtonNext
    Wait Until Element Is Visible    css:p.downloadSummaryPdf a.btn-outline-primary
    
    Field Data Is Validated    css:div.question-text:nth-child(2) div.field    ${firstName}
    Field Data Is Validated    css:div.question-text:nth-child(3) div.field    ${lastName}
    Field Data Is Validated    css:div.question-text:nth-child(4) div.field    ${extension}
    Field Data Is Validated    css:div.question-textarea div.answer.mb-3 p    ${address}
    Field Data Is Validated    css:div.question-location div.answer.mb-3 p    ${postalCode}
    Field Data Is Validated    css:div.question-locationCountry div.answer.mb-3 p    ${country}
    Field Data Is Validated    css:div.question-upload div.answer.mb-3 a    ${fileName.lower()}
    Field Data Is Validated    css:div.question-radio li    ${gender}
    Field Data Is Validated    css:div.question-dropdown div.answers p    ${role}
    Field Data Is Validated    css:div.question-richtext div.answers p    ${objective}
    
    ${tools}    Get WebElements    css:div.question-checkbox li
    FOR    ${tool}    IN    @{tools}
        ${actualTool}    Get Text    ${tool}
        Should Contain    ${toolsList}    ${actualTool}
    END

