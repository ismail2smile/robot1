*** Settings ***
Documentation    Test Suite for Prime Number Checker
Library    BuiltIn


*** Test Cases ***
Test1
    Log	Hello, world!

Test2
    [Tags]    Sprint 2    Bug Fix
    Log	Hello, world! test 2***

Test3
    [Tags]    Sprint 3    Version-4    Bug Fix
    ${dict}=  Create Dictionary  t1=8  t2=9  t3=10  t4=@{1,3,4,2,5,6,3,2}
    ${tempKey}=  Set Variable   t2
    ${tempKey2}=  Set Variable   ${dict}[t4][3]
    ${tempKey2}=  Convert To String  ${tempKey2}
    Log  ${dict}[t2]
    Log  ${dict}[${tempKey}]
    ${result}  MyKeyword1  ${dict}[${tempKey}]  ${tempKey2}
    Log  ${result}
    ${isPassed}=  Run Keyword If  ${result} < 20  success  ELSE  BuiltIn.Fail  Log "**Failed** ${result} greater then 20"
    Log  "******* ${isPassed}"
    CompareArray  ${dict}[t4]



Test4
    Log  Only me needto execute



*** Keywords ***

success
    Log  "test case passed"


MyKeyword1
    [Arguments]    ${arg1}  ${arg2}
    Log	 MyKeyword1 2***
    Log  ${arg1}
    Log  ${arg2}

    RETURN  ${${arg1}+${arg2}}


CompareArray
    [Arguments]   ${argList}

    ${agrLength}=  Get Length  ${argList}
    @{localList}=  Create List  ${2}  ${3}  ${4}  ${5}  ${6}

    ${Counter}=  Convert To Integer  ${0}
    FOR  ${item}  IN  @{localList}
        FOR    ${index}  IN RANGE  ${agrLength}
             ${intItem}=  Convert To Integer  ${argList}[${index}]
            IF  ${item} == ${intItem}
                Log  "Matching ${item} = ${intItem}"
                ${Counter}  Evaluate  ${Counter} + 1
                BREAK
            END
        END
    END
    Log  ${Counter}
    ${localLength}=  Get Length  ${localList}
    IF    ${Counter} == ${localLength}
        Log  "All items found in responce"
    ELSE
        FAIL  "Items did not match with each other"
    END

IncrementCounter
        [Arguments]    ${var}
        RETURN  ${${var}+1}

