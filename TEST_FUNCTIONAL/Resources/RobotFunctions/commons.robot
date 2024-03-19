*** Settings ***
Documentation   Common Keywords For Automation Framework
...             File Version 1.0
Library         Collections
Library         RPA.Browser.Selenium
Library         Process
Library         DateTime
Library         OperatingSystem
Library         RequestsLibrary
Library         String
Library         RPA.JSON
Library         RPA.Desktop

*** Variables ***
${pipeline}            local
${browser}             chrome

*** Keywords ***
Setup Environment and Open Browser
    [Documentation]     This keyword will establish the environment variables and open a browser
    [Arguments]    ${browserURL}
    Set Library Search Order    RPA.Browser.Selenium
    Open Browser To URL    ${browserURL}
    Browser timeout and speed

Open Browser To URL
    [Documentation]    Open browser and navigate to URL with browser options set
    [Arguments]    ${browserURL}
    Launch Browser    ${pipeline}    ${browserURL}
    Set Window Size    1980    1080
    Maximize Browser Window

Launch Browser
    [Arguments]    ${pipeline}    ${session_url}
    IF    "${pipeline}"=="gitlab"
        Open Browser in Gitlab    ${session_url}
    ELSE IF    "${pipeline}"=="local"
        Launch Local Browser    ${session_url}
    END

Open Browser in Gitlab
    [Arguments]    ${session_url}
    Run Keyword If      "${browser}"=="headlesschrome"      Launch Headless Chrome    ${session_url}
    Run Keyword If      "${browser}"=="headlessfirefox"     Launch Headless Firefox    ${session_url}

Launch Local Browser  
    [Arguments]    ${session_url}
    Open Browser     ${session_url}    ${browser}    options=add_experimental_option("excludeSwitches" , ["enable-automation","load-extension"])
    ${isVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    Xpath=//*[@id="body"]  2  
    Run Keyword If    '${isVisible}' == 'True'    Click Element    Xpath=//*[@id="body"]
    Run Keyword If    '${isVisible}' == 'True'    Type Text    thisisunsafe

Browser timeout and speed
    [Documentation]     Set browser timeout and speed
    Set Selenium Timeout   30s
    Set Selenium Speed   0s

Launch Headless Chrome
    [Documentation]    Open browser and navigate to URL with browser options set
    [Arguments]    ${session_url}
    ${webdriverchromeOptions}    Set Headless Chrome Options
    Create Webdriver    Chrome    chrome_options=${webdriverchromeOptions}
    Go To    ${session_url}
    Maximize Browser Window

Launch Headless Firefox
    [Arguments]    ${session_url}
    Open Browser      ${session_url}       ${browser}      options=add_argument("--ignore-certificate-errors")

Set Headless Chrome Options
    [Documentation]     Set the Chrome options for running in headless mode.  Restrictions do not apply to headless mode.
    ${chromeOptions}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys 
    Call Method    ${chromeOptions}    add_argument    test-type
    Call Method    ${chromeOptions}    add_argument    --headless
    Call Method    ${chromeOptions}    add_argument    --disable-extensions
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Call Method    ${chromeOptions}    add_argument    --disable-dev-shm-usage
    Call Method    ${chromeOptions}    add_argument    --no-sandbox
    Call Method    ${chromeOptions}    add_argument    --ignore-certificate-errors
    Call Method    ${chromeOptions}    add_argument    --ignore-ssl-errors
    Call Method    ${chromeOptions}    add_argument    --excludeSwitches
    [Return]  ${chromeOptions}

Set Chrome Options
    [Documentation]     Set the Chrome options for running in remote mode.
    ${chromeOptions}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chromeOptions}    add_argument    test-type
    Call Method    ${chromeOptions}    add_argument    --disable-extensions
    Call Method    ${chromeOptions}    add_argument    --disable-gpu
    Call Method    ${chromeOptions}    add_argument    --disable-dev-shm-usage
    Call Method    ${chromeOptions}    add_argument    --no-sandbox
    Call Method    ${chromeOptions}    add_argument    --ignore-certificate-errors
    Call Method    ${chromeOptions}    add_argument    --ignore-ssl-errors
    Call Method    ${chromeOptions}    add_argument    --excludeSwitches
    Call Method    ${chromeOptions}    add_argument    --timezone\="New_York"
    Call Method    ${chromeOptions}    add_argument    --geoLocation\="NY"
    [Return]  ${chromeOptions}