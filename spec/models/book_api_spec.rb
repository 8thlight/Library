require 'spec_helper'

describe BookAPI do
  BookStruct = Struct.new(:title, :authors)

  before do
    book = BookStruct.new
    book.title = "Agile Web Development With Rails"
    book.authors = "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt"
    BookAPI.stub(:find).and_return(book)
  end

  context "Google Book API" do

    let(:book) { BookAPI.find("9781934356548") }

    it "should retrieve the title of a book" do
      book.title.should == "Agile Web Development With Rails"
    end

    it "should retrieve the author of a book" do
      book.authors.should == "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt"
    end
  end
end
