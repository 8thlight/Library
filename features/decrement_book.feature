Feature: Decrement book

  Scenario: decrementing a abook
    Given I am a Librarian
    Given There is a book "Mobile First"
    When I decrement the book "Mobile First"
    Then The quantity should be 0
