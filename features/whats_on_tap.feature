Feature: What's On Tap

  Background:
    Given I am part of the org
    And I have logged in

  Scenario: see the current kegs on tap
    When I visit the "home" page
    Then I should see the beers that are on tap
