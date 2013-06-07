Feature: Show book details
  Scenario:
    Given a reader
    Given the reader has not checked out the book
    When the reader sees the show page for that book
    Then the return and waiting list link should not appear.
