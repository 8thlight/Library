Feature: Checkout book

  Scenario: A reader checks out a book
    Given a reader
    Given there is a book called "Mobile first" with quantity 1
    When the reader checks out the book "Mobile first"
    Then the book is checked out
