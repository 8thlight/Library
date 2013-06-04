Feature: Reader can view their books

  Scenario:
    Given a reader
    When the reader looked at the books I have checked out
    And the reader has checked out the book "Mobile first"
    And the reader has checked out the book "Rails way"
    Then I see "Mobile first"
    And I see "Rails way"
