require 'spec_helper'

describe Book do

  context "validations" do
    it "should reject duplicate ISBNs" do
      Book.create!(title: "rspec Tutorial",author: "Michael Hartl",isbn: "1234542341",quantity: 1)
      book_with_same_isbn = Book.new(title: "Rails ",author: "Anish Kothari",isbn: "1234542341",quantity: 31)
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
      book = Book.new(title: "rails", author: "Michael", isbn: "1234avd", quantity: "one")
      book.should have(1).error_on(:quantity)
    end

    it "should invalidate ISBNs shorter than 10 digits and longer than 13 digits" do
      book = Book.new(title: "Yo", author: "me", isbn: "1", quantity: 1)
      book.should have(1).error_on(:isbn)
    end
  end
end
