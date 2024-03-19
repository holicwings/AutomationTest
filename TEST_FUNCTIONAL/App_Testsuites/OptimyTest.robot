*** Settings ***
Documentation      Sample Test Script For Optimy Site
...                File Version 1.0
Resource           ../Resources/RobotFunctions/commons.robot
Resource           ../Resources/RobotFunctions/optimy.robot
Resource           ../Resources/RobotLocators/optimy.object.robot
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
OptimyTest.TC01 - Verify If New Application Is Successfully Submitted
    GIVEN User Login To Application
    WHEN User Submits A New Application
    THEN Input Data Is Validated Correctly
    AND New Application Is Successfully Submitted

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
    Select Postal Code    ${postalCode}
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

New Application Is Successfully Submitted
    Scroll Element Into View    css:div.d-none button#submitButton
    Click Element   css:div.d-none button#submitButton

    Wait Until Element Is Visible    css:div.text-success+h1
    ${successMessage}    Get Text    css:div.text-success+h1
    Should Be Equal    ${successMessage}    Thank you for submitting your project

Input Data Is Validated Correctly
    Wait Until Element Is Not Visible    css:button#navButtonNext
    Wait Until Element Is Visible    css:p.downloadSummaryPdf a.btn-outline-primary
    
    Field Data Is Validated   ${firstNameDataPath}    ${firstName}
    Field Data Is Validated   ${lastNameDataPath}     ${lastName}
    Field Data Is Validated   ${extensionDataPath}    ${extension}
    Field Data Is Validated   ${addressDataPath}      ${address}
    Field Data Is Validated   ${postalCodeDataPath}   ${postalCode}
    Field Data Is Validated   ${countryDataPath}      ${country}
    Field Data Is Validated   ${fileNameDataPath}     ${fileName.lower()}
    Field Data Is Validated   ${genderDataPath}       ${gender}
    Field Data Is Validated   ${roleDataPath}         ${role}
    Field Data Is Validated   ${ojectiveDataPath}     ${objective}
    
    ${tools}    Get WebElements    ${toolsDataPath}
    FOR    ${tool}    IN    @{tools}
        ${actualTool}    Get Text    ${tool}
        Should Contain    ${toolsList}    ${actualTool}
    END