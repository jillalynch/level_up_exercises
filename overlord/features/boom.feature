Feature: detonate bomb

  As a user
  I need to configure the bomb
  So that I can configure the bomb

  Background:
    Given: the bomb is armed

  Scenario: too many incorrect guesses
    When I enter the wrong code three times
    Then the bomb will detonate