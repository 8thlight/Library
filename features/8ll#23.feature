Feature: Avoid Race Condition
  As the first user of hundred users
  I want to be able to checkout a book
  So that the other ninety-nine users cannot

  Scenario: 100 users checking out same book
    Given there is one book called "The Great Gatsby"
    When hundred users check out the book at the same time
    Then one of the hundred users should be able to check out the book
    And the other ninety-nine users should receive a message that the book is already checked out
    And the quantity is 0, not a negative number
