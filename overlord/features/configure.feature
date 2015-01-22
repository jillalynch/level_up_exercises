Feature: configure codes

  As a user
  I need to configure the bomb
  So that it works

  Background:
    Given I visit the site

  Scenario: sets activation code
    When I set the activation code to "1111"
    Then the bomb is not armed

  Scenario: sets deactivation code
    When I set the deactivation code to "2222"
    Then the bomb is not armed