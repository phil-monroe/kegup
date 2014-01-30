Feature: What's On Tap

  Background:
    Given I am part of the org
    And I have logged in

  Scenario: see the current kegs on tap for an org
    When I visit an "org's" page
    Then I should see the beers that are on tap

  Scenario: see the previous kegs on tap for an org
    When I visit an "org's" page
    Then I should see the previous 10 tapped beers