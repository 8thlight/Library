require 'spec_helper'

describe ReturnController do
  describe "POST create" do

    let(:check_out) {mock_model(Checkout)}
    let(:book) {mock_model(Book)}
    let(:user) {User.create(email: "tak.yuki@gmail.com", name: "Taka")}
    let(:wait_list) {Waitinglist.create(user_id: user.id, book_id: 1)}


    before do
      book.stub(:isbn).and_return("9781934356371")
    end

    describe "#notify_if_waitlist" do
      it "notifies the user thats on the waitlist that the book is available" do
        Waitinglist.stub_chain(:where,:first).and_return(wait_list)
        book.stub(:get_attr).and_return("title")
        subject.notify_if_waitlist(book)
        ActionMailer::Base.deliveries.last.to.should == [user.email]
      end
    end

    it "redirects to the root path" do
      create "return"
      response.should redirect_to root_path
    end

    context "when there are no checkouts" do
      it "does not destroy the checkout history" do
        check_out.stub(:any?).and_return(false)
        create "return"
        flash[:notice].should == "Could not return book."
      end

      it "destroys the checkout history" do
        subject.stub(:notify_if_waitlist)
        subject.stub(:increment_quantity)
        Checkout.should_receive(:destroy)
        Checkout.stub(:where).and_return(check_out)
        check_out.stub(:any?).and_return(true)
        create "return"
      end
    end

    context "when there are checkouts" do
      it "#increment quantity" do
        book = Book.create(isbn: "9781934356371", quantity: 2, quantity_left: 2)
        subject.increment_quantity(book)
        book.quantity_left.should eq(3)
      end
    end
  end
end
