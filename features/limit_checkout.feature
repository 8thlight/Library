Feature: limit checkouts to 5
  Scenario:
    Given I am reader Taka
    When I have 5 books checked out
    And I try to checkout a 6th book
    Then I should get an error
