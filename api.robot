*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
#Resource   Resourrces/keywords.resource
#Resource   Resourrces/variables.resource
Library    JSONLibrary
Library    OperatingSystem

*** Variables ***
${mock_API}     https://run.mocky.io/v3/be06c2c6-e55b-4d02-be19-8c471fff9ab7
${test_API}     https://gorest.co.in/public/v2/users


*** Test Cases ***
GET request and verify the responce
    [Documentation]    GET session and verify status_code
    Run Keyword    Create Session    mysession     ${mock_API}         verify=True
    ${response}=    GET On Session    mysession     ?
    Run Keyword    Status Should Be    200  ${response}
    #get JSON from response
    ${Json}=    Set Variable    ${response.json()}
#    Log To Console    ${Json}
    ${data}=    Set Variable    ${Json["data"]["nodes"]}
    Verify id                   ${data}

*** Keywords ***
Verify id
    [Arguments]    ${API_List}

    ${Json}    Get File         jsonFile.json   #import local json file
    ${loadJson}    Evaluate     json.loads('''${Json}''')       json
    ${data}=	Convert To Dictionary	    ${loadJson}
    ${JsonList}=     Set Variable           ${data["data"]["nodes"]}

    @{appendList}=      Create List
#    Log To Console    @{appendList}
    ${counter}=     Convert To Integer    0

    FOR    ${api_id}    IN      @{API_List}
        FOR    ${local_id}      IN      @{JsonList}
            IF    '${local_id["id"]}' == '${api_id["id"]}'
#                Log To Console    "PASSED" ${counter}
                ${counter}  Evaluate    ${counter} + 1
                Exit For Loop
#            ELSE
#                Append To List    ${appendList}     ${local_id["id"]}
            END
        END
    END
    ${Len_API_List}=    Get Length    ${API_List}
    IF    ${counter} == ${Len_API_List}
        Log To Console   ${counter} "MATCHED"

    ELSE
        Condition Failed    ${counter}  ${Len_API_List}
    END


Condition Failed
    [Arguments]    ${counter}   ${Len_API_List}
    Fail   ${${Len_API_List}-${counter}} FAILED



