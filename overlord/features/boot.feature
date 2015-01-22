Feature: boot bomb

  As a user
  I need to boot the bomb
  So that I can use it

  Scenario: boots bomb
    When I visit the site
    Then the bomb is not armed
