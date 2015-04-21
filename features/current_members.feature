Feature: viewing all current members
  As a fan of Cal Raijin Taiko
  So that I can see who the current members of the team are
  I want to be able to go to the members page and see all the current members

  Background:
    Given 20 current members exist

  Scenario Outline: viewing all current members on different pages
    When I am on the <page> page
    Then I should see the name of every current member

    Examples:
      | page            |
      | members         |
      | current members |
