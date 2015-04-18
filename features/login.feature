Feature: Registered users can login to the administrative account
  As an authorized member of the team
  So that I can keep the website content up to date
  I want to be able to login to the administrative account

  Background:
    Given I have an account with username "caltaiko" and password "secret" and email "test@example.com"
    And I am on the login page

  Scenario: I can enter my login using my username
    When I try to log in with username "caltaiko" and password "secret"
    Then I should be logged in

  Scenario: I can login using my email address
    When I try to log in with email "test@example.com" and password "secret"
    Then I should be logged in

  Scenario: invalid login credentials should be refused
    When I try to log in with username "poop" and password "peep"
    Then I should not be logged in
    And I should see "Invalid login or password"
