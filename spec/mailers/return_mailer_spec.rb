require 'spec_helper'

describe ReturnMailer do
  describe "instructions" do
    let(:user) {mock_model(User, :name => "taka", :email => "tak.yuki@gmail.com")}
    let(:book) {mock_model(Book, :isbn => "9781934356371", :quantity => 2)}
    let(:mail) {ReturnMailer.notify_book_available(user, book)}

    before(:each) do
      book.stub(:get_attr).and_return("title")
    end

    it "renders the subjects" do
      mail.subject.should == "There is a book available for you!"
    end

    it "renders the receiver email" do
      mail.to.should == [user.email]
    end
  end
end
