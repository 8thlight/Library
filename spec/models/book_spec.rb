require 'spec_helper'
require 'net/ping'

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

def new_book(isbn, quantity)
  Book.new(isbn: isbn, quantity: quantity)
end

describe Book, :slow_tests => true do

  context "validations" do
    it "should reject duplicate ISBNs" do
      Book.create!(isbn: "9781937557027",quantity: 1)
      book_with_same_isbn = new_book("9781937557027", 31)
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
      new_book("1234123456", "one")
      subject.should have(2).error_on(:quantity)
    end

    it "should invalidate ISBNs shorter than 10 digits and longer than 13 digits" do
      new_book("1", 1)
      subject.should have(1).error_on(:isbn)
    end

    it "should check ISBN does not exists" do
      new_book("9780321287654", 1)
      subject.validate_isbn.should be_false
    end
  end

  describe "Google Book API", :if => :network_available do
    {
      "9781934356548" => "Agile Web Development With Rails",
      "9781937557027" => "Mobile first"
    }.each do |isbn, title|
      it "should retrieve the title #{title} passing the isbn #{isbn}" do
        book = new_book(isbn, 1)
        book.get_title.should == title
      end
    end

    {
      "9781934356548" => "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt",
      "9781937557027" => "Luke Wroblewski"
    }.each do |isbn, author|
      it "should retrieve the author #{author} with the isbn #{isbn}" do
        book = new_book(isbn, 1)
        book.get_author.should == author
      end
    end
  end
end







