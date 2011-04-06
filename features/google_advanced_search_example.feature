Feature: As a user wanting to use Google's advanced search 

  Scenario: I want to find information about cucumber testing
    Given I am on the Google Advanced Search site
    And I fill out all these words field with "cucumber"
    And I add "bdd" to a one or more of these words field
    And I  add "vegetables" and "pickles" to the any of these unwanted words field
    When I click "Advanced Search"
    Then I should see "cucumber bdd -vegetables -pickles" in the search field
    And I should see "Cucumber - Making BDD fun"
