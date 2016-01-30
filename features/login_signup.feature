Feature: signup and login as a user
  
  As a site user
  So that I use the app's services
  I want to be able to signup, login
  
Background:
    
    Given the following users exist:
    | name      | email       | password  |
    | test1     | test1@me.me | 12345678  |
    
Scenario: signup as a new user
  Given I am on signup page
  When  I fill in "Name" with "Test_Account"
  And   I fill in "Email" with "noone@nowhere.com"
  And   I fill in "Password" with "12345678"
  And   I fill in "Password confirmation" with "12345678"
  And   I press "Sign up"
  Then  I should see "Welcome, Test_Account"
  
Scenario: login as existing user
  Given I am on login page
  When  I fill in "Email" with "test1@me.me"
  And   I fill in "Password" with "12345678"
  And   I press "Log in"
  Then  I should see "Welcome, test1"
  