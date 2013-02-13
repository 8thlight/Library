require 'spec_helper'

describe Book do

  context "validations" do
    it "should reject duplicate ISBNs" do
      Book.create!(isbn: "1234542341",quantity: 1)
      book_with_same_isbn = Book.new(isbn: "1234542341",quantity: 31)
      book_with_same_isbn.should_not be_valid
    end

    {
      :quantity => 2
    }.each do |attr, num|
      it "should validate the presence of #{attr}" do
        subject.should have(num).error_on(attr)
      end
    end

    it "should validate the quantity is an integer" do
      book = Book.new(isbn: "1234123456", quantity: "one")
      book.should have(1).error_on(:quantity)
    end

    it "should invalidate ISBNs shorter than 10 digits and longer than 13 digits" do
      book = Book.new(isbn: "1", quantity: 1)
      book.should have(1).error_on(:isbn)
    end
  end
end
