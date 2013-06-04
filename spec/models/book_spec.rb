require 'spec_helper'

def new_book(isbn, quantity)
  Book.new(isbn: isbn, quantity: quantity)
end

describe Book do
  it { should have_many(:checkouts) }
  it { should have_many(:waitinglist) }
  it { should have_many(:users).through(:waitinglist) }
  it { should validate_uniqueness_of(:isbn) }
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity) }
  it { should ensure_length_of(:isbn) }

  context "validations" do
    it "should reject duplicate ISBNs" do
      described_class.create!(isbn: "9781937557027",quantity: 1)
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
      subject.should have(1).error_on(:isbn)
    end

    it "should add an error when the api book is empty" do
      subject.stub_chain(:api_book, :empty?).and_return(true)
      subject.validate_isbn.should be_false
    end
  end

  describe "Google Book API" do
    {
      "9781934356548" => "Agile Web Development With Rails",
      "9781937557027" => "Mobile first"
    }.each do |isbn, title|
      it "should retrieve the title #{title} passing the isbn #{isbn}" do
        book = new_book(isbn, 1)
        book.get_attr("title").should == title
      end
    end

    {
      "9781934356548" => "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt",
      "9781937557027" => "Luke Wroblewski"
    }.each do |isbn, author|
      it "should retrieve the author #{author} with the isbn #{isbn}" do
        book = new_book(isbn, 1)
        book.get_attr("author").should == author
      end
    end
  end
end







