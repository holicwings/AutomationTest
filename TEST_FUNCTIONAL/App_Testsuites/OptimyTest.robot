*** Settings ***
Documentation      Sample Test Script For Optimy Site
...                File Version 1.0
Resource           ../Resources/RobotFunctions/commons.robot
Resource           ../Resources/RobotFunctions/optimy.robot
Resource           ../Resources/RobotLocators/optimy.object.robot
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
    Click Element When Clickable   ${submitANewApplicationButton}
    Wait Until Element is Visible  ${continueWithSubmissionHeaderPath}
    Page Is Navigated Correctly    ${continueWithSubmissionText}
    ${h1Text}       Get Text       ${continueWithSubmissionHeaderPath}
    ${isVisible}    Run Keyword And Return Status    Should Be Equal    ${h1Text}    ${continueWithSubmissionText}
    Run Keyword If    ${isVisible} == ${True}    Submit New Application
    Page Is Navigated Correctly         Fill-out all forms
    Input Field Data      First name    ${firstName}
    Input Field Data      Last name     ${lastName}
    Input Field Data      Extension     ${extension}
    Input Address         ${address}
    Select Postal Code    ${postalCode}
    Select From List By Label    ${countrySelectionList}    ${country}
    Upload Photo          ${filePath}
    Select Gender         ${gender}
    Select From List By Label    ${roleSelectionList}       ${role}
    FOR    ${tool}    IN    @{toolsList}
        Tick Tools Checkbox      ${tool}
    END
    Input Career Objective           ${objective}
    Click Element When Visible       ${nextScreenButton}

Input Data Is Validated Correctly
    Page Is Navigated Correctly    Fill-out all forms
    Wait Until Element Is Not Visible    ${nextScreenButton}
    Wait Until Element Is Visible        ${downloadSummaryButton}

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

New Application Is Successfully Submitted
    Scroll Element Into View        ${validateAndSendButton}
    Click Element                   ${validateAndSendButton}
    Page Is Navigated Correctly     Summary
    Wait Until Element Is Visible   ${successHeaderPath}
    ${successMessage}    Get Text   ${successHeaderPath}
    Should Be Equal      ${successMessage}    ${successHeaderText}