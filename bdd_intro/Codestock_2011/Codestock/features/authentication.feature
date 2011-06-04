Feature: Authentication
  In order to authenticate to the application
  As a user
  I want to gain access to the application
  
  Scenario: Sign In page should exist
    Given I am on the signin page
    Then I should see "Sign In"
    
  Scenario: An existing user can sign in successfully to the application with a valid email and password
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Email Address" with "joe@example.com"
    And I fill in "Password" with "p@ssword1"
    And I press "Sign In"
    Then I should be on the root page
  
  Scenario: An existing user can sign in successfully to the application without regard to the case sensitivity of the email address
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Email Address" with "Joe@example.com"
    And I fill in "Password" with "p@ssword1"
    And I press "Sign In"
    Then I should be on the root page
    
  Scenario: An existing user is denied access to the application with a valid email but an invalid matching password
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Email Address" with "Joe@example.com"
    And I fill in "Password" with "password1"
    And I press "Sign In"
    Then I should be on the new session page
    And I should see "Incorrect email/password combination"
  
  Scenario: A password that does not match the original case will deny the user access to the application
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Email Address" with "Joe@example.com"
    And I fill in "Password" with "P@ssword1"
    And I press "Sign In"
    Then I should be on the new session page
    And I should see "Incorrect email/password combination"
  
  Scenario: An existing user is denied access to the application with a missing email
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Password" with "p@ssword1"
    And I press "Sign In"
    Then I should be on the new session page
    And I should see "Incorrect email/password combination"
  
  Scenario: An existing user is denied access to the application with a missing password
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Email Address" with "Joe@example.com"
    And I press "Sign In"
    Then I should be on the new session page
    And I should see "Incorrect email/password combination"
  
  Scenario: An existing user is denied access to the application with an invalid formatted email
    Given a user exists with email: "joe@example.com", password: "p@ssword1"
    And I am on the signin page
    When I fill in "Email Address" with "Joe@example"
    And I fill in "Password" with "p@ssword1"
    And I press "Sign In"
    Then I should be on the new session page
    And I should see "Incorrect email/password combination"