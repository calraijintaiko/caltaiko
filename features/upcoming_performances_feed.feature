Feature: upcoming performances should be listed in a feed on the front and
  upcoming performances pages

  As a fan of Cal Raijin Taiko
  So that I can see when and where the team is performing next
  I want to see a feed of all the upcoming performances

  Background:
    Given there are 5 upcoming performances

  Scenario Outline: viewing feed on different pages
    When I am on the <page> page
    Then I should see every upcoming performance

    Examples:
      | page                  |
      | home                  |
      | performances          |
      | upcoming performances |

  Scenario Outline: message is displayed if there are no upcoming performances
    When there are no upcoming performances
    And I am on the <page> page
    Then I should see "Stay tuned for more information soon!"

    Examples:
      | page                  |
      | home                  |
      | performances          |
      | upcoming performances |
