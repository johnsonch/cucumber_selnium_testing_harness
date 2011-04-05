Feature: As a user on the TCCC website

  Scenario: I want to view the schedule
    Given I am on the TCCC website home page
    When I click on "Schedule"
    Then I should see "Spring 2011 - Schedule"

