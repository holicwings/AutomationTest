*** Variables ***


###Summary
${firstNameDataPath}    css:div.question-text:nth-child(2) div.field
${lastNameDataPath}    css:div.question-text:nth-child(3) div.field
${extensionDataPath}    css:div.question-text:nth-child(4) div.field
${addressDataPath}    css:div.question-textarea div.answer.mb-3 p
${postalCodeDataPath}    css:div.question-location div.answer.mb-3 p
${countryDataPath}    css:div.question-locationCountry div.answer.mb-3 p
${fileNameDataPath}    css:div.question-upload div.answer.mb-3 a
${genderDataPath}    css:div.question-radio li
${roleDataPath}    css:div.question-dropdown div.answers p
${ojectiveDataPath}    css:div.question-richtext div.answers p
${toolsDataPath}    css:div.question-checkbox li