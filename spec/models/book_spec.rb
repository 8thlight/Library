require 'spec_helper'

describe Book do
  before(:each) do
    @attributes =
      { :title    => "Rails Tutorial 3",
        :author   => "Michael Hartl",
        :isbn     => "1234abcd",
        :quantity => 2
    }
  end
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
end
