Feature: non-registered users cannot perform certain actions
  As an admin of the caltaiko website
  So that nobody can insert false information into the website
  I want certain actions to be restricted to users with admin privileges

  Background:
    Given I am not logged in
    And a member named "John Doe" exists
    And an article called "Go Us" exists
    And a performance called "Showcase" exists
    And a video called "Cute Cats" exists

  Scenario Outline: secure pages are restricted
    When I go to the <page>
    Then I should be on the login page
    And I should see "You need to sign in or sign up before continuing"

    Examples:
      | page                                 |
      | new member page                      |
      | new article page                     |
      | new performance page                 |
      | new video page                       |
      | edit page for member "John Doe"      |
      | edit page for article "Go Us"        |
      | edit page for performance "Showcase" |
      | edit page for video "Cute Cats"      |
