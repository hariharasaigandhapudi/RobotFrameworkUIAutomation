*** Settings ***
Resource    ../Resources/ui_resource.robot
Library  SeleniumLibrary  

#Test Setup  Test_setup
#Test Teardown   Test_teardown

*** Test Cases ***

#create_account
#    [Template]  Test case to create account
#    csv=input

Open Login Page
   Open Browser https://www.tutorialspoint.com/ browser=headlesschrome
   Maximize Browser Window
