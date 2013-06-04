Feature: Increment book

  Scenario: incrementing a book
    Given I am a Librarian
    Given There is a book "Mobile First" with quantity 1
    When I increment the quantity of the book "Mobile First"
    Then the quantity should be 2

#  Scenario: decrementing a abook
#    Given I am a Librarian
#    Given There is a book "Mobile First"
#    When I decrement the book "Mobile First"
#    And a single book exists with title "Mobile First" and a quantity of 1
#    Then the quantity should be 0
