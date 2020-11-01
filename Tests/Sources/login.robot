*** Settings ***
Resource    ../Resources/ui_resource.robot

Test Setup  Test_setup
Test Teardown   Test_teardown

*** Test Cases ***

create_account
    [Template]  Test case to create account
    csv=input
