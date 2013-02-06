require 'spec_helper'

describe Book do

  context "validations" do
    it "should reject duplicate titles" do
      Book.create!(title: "Rails Tutorial",author: "Michael Hartl",isbn: "124432",quantity: 1)
      book_with_same_name = Book.new(title: "Rails Tutorial",author: "Anish Kothari",isbn: "12333321",quantity: 31)
      book_with_same_name.should_not be_valid
    end

    it "should reject duplicate ISBNs" do
      Book.create!(title: "Rails Tutorial",author: "Michael Hartl",isbn: "124432",quantity: 1)
      book_with_same_isbn = Book.new(title: "Rails ",author: "Anish Kothari",isbn: "124432",quantity: 31)
      book_with_same_isbn.should_not be_valid
    end

    {
      :title => 1,
      :isbn => 1,
      :author => 1,
      :quantity => 1
    }.each do |attr, num|
      it "should validate the presence of #{attr}" do
        subject.should have(num).error_on(attr)
      end
    end
  end
end
