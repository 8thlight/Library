Feature: Increment book

  Scenario: incrementing a book
    Given I am a Librarian
    Given There is a book "Mobile First" with quantity 1
    When I increment the quantity of the book "Mobile First"
    Then the quantity should be 2

