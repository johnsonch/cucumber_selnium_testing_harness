Feature: As a person using boozefindr.com

  Scenario: I want to find a place to have an adult beverage
    Given I am at boozefindr.com
    And I search for "Revelstoke" near "Eau Claire, WI"
    When I click "Booze Me!"
    Then I should see the search results page
    And I should see "Mogies Pub"
    And I should see "Search results for Revelstoke in Eau Claire, WI"

