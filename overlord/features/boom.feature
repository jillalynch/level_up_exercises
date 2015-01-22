Feature: detonate bomb

  As a user
  I need to configure the bomb
  So that I can configure the bomb

  Background:
    Given: the bomb is armed

  Scenario: timer expires
    When the timer equals zero
    Then the bomb should detonate

  Scenario: too many incorrect guesses
    When I enter the wrong code three times
    Then the bomb will detonate