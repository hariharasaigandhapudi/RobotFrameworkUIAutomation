*** Settings ***
Resource    ../Resources/ui_resource.robot
Library  SeleniumLibrary  

#Test Setup  Test_setup
#Test Teardown   Test_teardown

*** Test Cases ***

create_account
    [Template]  Test case to create account
    csv=input

