Feature: Search Books

  Scenario: Search by isbn
    Given a reader
    Given there are multiple books
    When I create a book Mobile First
    When I fill in the search bar with the isbn of Mobile First
    Then the book "Mobile first" is displayed from isbn

