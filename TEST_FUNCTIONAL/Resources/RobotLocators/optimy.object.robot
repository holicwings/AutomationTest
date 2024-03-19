*** Variables ***
###Login
${allowNecessaryCookiesOnlyButton}    css:button#cookie-allow-necessary-button
${loginHeaderButton}    css:a.ml-auto
${emailField}           css:#login-email
${passwordField}        css:#login-password
${loginButton}          css:form#login-form button[type\="submit"]
${myAccountIcon}        css:span[data-original-title\="My account"]

###Submit New Application
${submitNewApplicationButton}          css:a[href^\='/en/project/new/'].btn-outline-primary
${projectSteps}                        css:a.projectStepsLink
${submitANewApplicationButton}         css:a.btn-primary  
${continueWithSubmissionHeaderPath}    css:div.page-main__content-wrapper h1
${continueWithSubmissionText}          Continue with the submission of an application?

###Input Data
${addressInputField}        css:div.field textarea
${uploadPhotoInputField}    css:input[name\="Filedata"][type\="file"]
${postalCodeSelectionList}  css:ul.ui-menu a
${countrySelectionList}     css:select.locationCountry.custom-select
${roleSelectionList}        css:select[aria-label\="Select a role you're applying for"]
${careerObjectiveIFrame}    css:iframe[title^\='Editor']
${careerObjectiveTextBox}   css:body[role\="textbox"]
${nextScreenButton}         css:button#navButtonNext

###Summary
${downloadSummaryButton}    css:p.downloadSummaryPdf a.btn-outline-primary
${firstNameDataPath}        css:div.question-text:nth-child(2) div.field
${lastNameDataPath}         css:div.question-text:nth-child(3) div.field
${extensionDataPath}        css:div.question-text:nth-child(4) div.field
${addressDataPath}          css:div.question-textarea div.answer.mb-3 p
${postalCodeDataPath}       css:div.question-location div.answer.mb-3 p
${countryDataPath}          css:div.question-locationCountry div.answer.mb-3 p
${fileNameDataPath}         css:div.question-upload div.answer.mb-3 a
${genderDataPath}           css:div.question-radio li
${roleDataPath}             css:div.question-dropdown div.answers p
${ojectiveDataPath}         css:div.question-richtext div.answers p
${toolsDataPath}            css:div.question-checkbox li
${validateAndSendButton}    css:div.d-none button#submitButton

###Confirmation
${successHeaderPath}        css:div.text-success+h1
${successHeaderText}        Thank you for submitting your project