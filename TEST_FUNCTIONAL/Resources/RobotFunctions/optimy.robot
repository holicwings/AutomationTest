*** Settings ***
Documentation   Common Keywords Used For Optimy
...             File Version 1.0
Library         Collections
Library         RPA.Browser.Selenium
Resource        ../RobotLocators/optimy.object.robot

*** Keywords ***
Allow Necessary Cookies Only
    Wait Until Element Is Visible        ${allowNecessaryCookiesOnlyButton}    10
    Click Element                        ${allowNecessaryCookiesOnlyButton}
    Wait Until Element Is Not Visible    ${allowNecessaryCookiesOnlyButton}    10

Login To App
    [Arguments]    ${userName}    ${password}
    ${isLoginvisible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${loginHeaderButton}    5
    Run Keyword If    ${isLoginvisible} == True    Click Element    ${loginHeaderButton}
    Wait Until Element Is Visible     ${emailField}    
    Input Text    ${emailField}       ${userName}
    Input Text    ${passwordField}    ${password}
    Wait Until Element Is Enabled     ${loginButton}
    Click Element                     ${loginButton}
    Wait Until Element Is Visible     ${myAccountIcon}

Submit New Application
    Scroll Element Into View        ${submitNewApplicationButton}
    Click Element When Clickable    ${submitNewApplicationButton}
    Wait Until Element Is Visible   ${projectSteps}

Page Is Navigated Correctly
    [Arguments]     ${pageTitle}
    ${pageTitle}    Get Title
    Should Contain  ${pageTitle}    ${pageTitle}

Input Field Data
    [Arguments]    ${fieldName}    ${fieldValue}
    Wait Until Element Is Visible    css:input[aria-label\="${fieldName}"]
    Input Text                       css:input[aria-label\="${fieldName}"]    ${fieldValue}

Input Address
    [Arguments]    ${fieldValue}
    Wait Until Element Is Visible        ${addressInputField}
    Input Text   ${addressInputField}    ${fieldValue}

Upload Photo
    [Arguments]    ${filePath}
    Choose File    ${uploadPhotoInputField}   ${EXECDIR}/${filePath}

Select Gender
    [Arguments]    ${gender}
    Wait Until ELement is visible    css:label.custom-control[aria-label\="${gender}"]
    Click Element                    css:label.custom-control[aria-label\="${gender}"]

Select Postal Code
    [Arguments]    ${postalCode}
    Input Field Data                 Select postal code          ${postalCode}
    Wait Until Element Is Visible    ${postalCodeSelectionList}
    Click Element                    ${postalCodeSelectionList}

Tick Tools Checkbox
    [Arguments]    ${toolName}
    Scroll Element Into View   css:label[aria-label\="${toolName}"]
    Click Element              css:label[aria-label\="${toolName}"]
    Sleep    0.5sec

Input Career Objective
    [Arguments]    ${objective}
    Wait Until Element Is Visible    ${careerObjectiveIFrame}
    Select Frame    ${careerObjectiveIFrame}
    Input Text      ${careerObjectiveTextBox}    ${objective}
    Unselect Frame

Field Data Is Validated
    [Arguments]        ${objectPath}    ${actualResult}
    ${actualText}      Get Text         ${objectPath}
    Should Be Equal    ${actualText}    ${actualResult}