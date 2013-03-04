require 'spec_helper'

RSpec.configure do |c|
  c.exclusion_filter = {
    :if => lambda {|connect|
      case connect
      when :network_available
        !Ping.pingecho "Kihon Library", 10, 80
      end
    }
  }
end

RSpec.configure do |c|
  c.exclusion_filter = { :slow_tests => false }
end

describe Book, :slow_tests => true do

  context "validations" do
    it "should reject duplicate ISBNs" do
      Book.create!(isbn: "9781937557027",quantity: 1, quantity_left: 1)
      book_with_same_isbn = Book.new(isbn: "9781937557027",quantity: 31, quantity_left: 31)
      book_with_same_isbn.should_not be_valid
    end

    {
      :quantity => 2,
      :isbn => 1
    }.each do |attr, num|
      it "should validate the presence of #{attr}" do
        subject.should have(num).error_on(attr)
      end
    end

    it "should validate the quantity is an integer" do
      book = Book.new(isbn: "1234123456", quantity: "one")
      subject.should have(2).error_on(:quantity)
    end

    it "should invalidate ISBNs shorter than 10 digits and longer than 13 digits" do
      book = Book.new(isbn: "1", quantity: 1)
      subject.should have(1).error_on(:isbn)
    end

    it "should check ISBN does not exists" do
      book = Book.new(isbn: "9780321287654", quantity: 1)
      subject.validate_isbn.should be_false
    end

    it "should check if there is an error if the ISBN does not exist" do
      book = Book.new(isbn: "9780321287654", quantity: 1)
      subject.should have(1).error_on(:isbn)
    end
  end

  describe "Google Book API", :if => :network_available do
    {
      "9781934356548" => "Agile Web Development With Rails",
      "9781937557027" => "Mobile first"
    }.each do |isbn, title|
      it "should retrieve the title #{title} passing the isbn #{isbn}" do
        book = Book.new(isbn: isbn, quantity: 1, quantity_left:1)
        book.get_title.should == title
      end
    end

    {
      "9781934356548" => "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt",
      "9781937557027" => "Luke Wroblewski"
    }.each do |isbn, author|
      it "should retrieve the author #{author} with the isbn #{isbn}" do
        book = Book.new(isbn: isbn, quantity:1, quantity_left:1)
        book.get_author.should == author
      end
    end
  end
end


























