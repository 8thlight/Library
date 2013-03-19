require 'spec_helper'

describe ReturnMailer do
  describe "instructions" do
    let(:user) {mock_model(User, :name => "taka", :email => "tak.yuki@gmail.com")}
    let(:mail) { ReturnMailer.notify_book_available(user)}

    it "renders the subjects" do
      mail.subject.should == "There is a book available for you!"
    end

    it "renders the receiver email" do
      mail.to.should == [user.email]
    end
  end
end
