Feature: disarm bomb

  As a user
  I need to type in a valid deactivation code
  So that I can disarm the bomb

  Background:
    Given the bomb is armed

  Scenario: arm the bomb
    When I enter the activation code
    Then the bomb is armed
    And  the timer starts
    #  expected ["Welcome to Codebreaker!"] to include "Enter guess:"