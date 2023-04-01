*** Settings ***
Documentation    Test Suite for Prime Number Checker
Library    BuiltIn

*** Test Cases ***
Check Prime Numbers
    [Tags]    PrimeNumbers
    Check if number is prime    7
    Check if number is prime    14
    Check if number is prime    23
    Check if number is prime    33



*** Keywords ***
Check if number is prime
    [Arguments]    ${number}
    Run Keyword If    ${number} < 2    Log    Number ${number} is not prime.
    Run Keyword If    ${number} == 2    Log    Number ${number} is prime.
    ${is_prime}=    Run Keyword And Return Status    ${number} > 2
    ...    ${number} % 2 != 0
    ...    Run Keyword And Return Status    For    ${i}    IN RANGE    3    ${number} // 2 + 1
    ...    ...    ${number} % ${i} != 0
    Run Keyword If    ${is_prime}    AND    ${is_prime} == True    Log    Number ${number} is prime.
    Run Keyword If    ${is_prime}    AND    ${is_prime} == False    Log    Number ${number} is not prime.
