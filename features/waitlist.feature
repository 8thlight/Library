Feature: Waitlist

  Scenario: Allow a raeder to add themselves to the waiting list
    Given I am reader Taka
    When I view the "Mobile first" show page
    And the book is all checked out
    Then I am able to add myself to the waiting list

  Scenario:
    Given I am reader Taka
    When I click "Add myself to the waiting list"
    And there is a "Mobile first" book checked out
    And I am viewing the "Mobile first" show page
    Then my name will appear at the top of the waiting list

