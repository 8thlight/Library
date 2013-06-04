Feature: return a book

  Scenario: Reader returns a book
    Given there is a book called "Mobile first"
    When I already checked out the book
    When I return the book
    Then the book is available for anyone else to check out
