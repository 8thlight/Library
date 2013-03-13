require 'spec_helper'

def hundred_users_checkout
  #User.create(email: "tak.yuki@gmail.com", name: "Taka")
  #Checkout.create(user_id: 1, book_id: 1, check_out_date: Time.now)
  #threads = Array.new(5) {Thread.new  {post :create, {:isbn => "9781934356371"}}}
  #threads.each(&:join)
end

describe CheckoutsController, :slow_tests => true do
  let (:check_out) {mock_model(Checkout).as_null_object}
  let (:book) {mock_model(Book).as_null_object}
  let (:user) {mock_model(User).as_null_object}


  describe "verify unique checkout" do
    it "validates that a user can only checkout one copy of a book" do
      Checkout.create(book_id: 1, check_out_date: Time.now, user_id: 1)
      checkout2 = Checkout.new(book_id: 1, check_out_date: Time.now, user_id: 1)
      subject.unique?(checkout2).should be_false
    end
  end

  describe "#check_waitlist" do

    it "returns true if waitlist is empty" do
      waiting = Waitinglist.new(book_id: 1, user_id:2, wait_since: Time.now)
      subject.check_waitlist(waiting, 2).should be_true
    end

    it "returns false if waitlist is not empty and user is not first in line" do
      Waitinglist.create(book_id: 1, user_id:1, wait_since: Time.now)
      waiting = Waitinglist.new(book_id: 1, user_id:2, wait_since: Time.now)
      subject.check_first_waitlist(waiting, 2).should be_false
    end
  end

  describe "#remove_from_waitinglist" do
    it "destroys waitinglist with userid and bookid" do
      remove_from_list = Waitinglist.create(book_id: 1, user_id: 1, wait_since: Time.now)
      subject.remove_from_waitinglist(1).should == remove_from_list
    end
  end

  describe "POST create" do
    let (:user) {mock_model(User)}

    before do
      User.stub(:find).and_return(user)
      Checkout.stub(:new).and_return(check_out)
      book = Book.create(isbn: "9781934356371", quantity: 2, quantity_left: 2)
      Book.stub(:find_by_isbn).and_return(book)
    end

    it "redirects to the checkouts index" do
      create "check out"
      response.should redirect_to(:action => "index")
    end

    it "saves the checkout" do
      check_out.should_receive(:save)
      create "check out"
    end

    context "when the checkout is saved successfully" do
      it "sets a flash[:notice] checkout" do
        create "check out"
        flash[:notice].should eq("the checkout was successful")
      end
    end

    context "when the checkout fails" do
      it "assigns @checkout" do
        check_out.stub(:save).and_return(false)
        create "check out"
        assigns[:check_out].should eq(check_out)
      end
    end
  end
end
