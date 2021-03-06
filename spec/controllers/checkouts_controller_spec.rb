require 'spec_helper'

describe CheckoutsController do
  let (:check_out) {mock_model(Checkout).as_null_object}
  let (:book) {mock_model(Book).as_null_object}
  let (:user) {mock_model(User).as_null_object}
  let (:waiting) {Waitinglist.new(book_id:1, user_id:2, wait_since: Time.now)}


  describe "#unique?" do
    it "validates that a user can only checkout one copy of a book" do
      Checkout.create(book_id: 1, check_out_date: Time.now, user_id: 1)
      checkout2 = Checkout.new(book_id: 1, check_out_date: Time.now, user_id: 1)
      subject.unique?(checkout2).should be_false
    end
  end

  describe "#check_waitlist" do

    it "returns true if waitlist is empty" do
      subject.check_waitlist(1, 2).should be_true
    end

    it "returns true if waiting is not empty but matches the first one on the list" do
      Waitinglist.stub(:empty?).and_return(false)
      subject.stub(:check_first_waitlist).and_return(true)
      subject.check_waitlist(1,2).should be_true
    end

    context "#check_first_waitlist" do
      it "returns false if waitlist is not empty and user is not first in line" do
        Waitinglist.create(book_id: 1, user_id:1, wait_since: Time.now)
        subject.check_first_waitlist(waiting, 2).should be_false
      end
    end
  end

  describe "#remove_from_waitinglist" do
    it "destroys waitinglist with userid and bookid" do
      remove_from_list = Waitinglist.create(book_id: 1, user_id: 1, wait_since: Time.now)
      subject.remove_from_waitinglist(1).should == remove_from_list
    end
  end

  describe "POST create" do

    before do
      User.stub(:find).and_return(user)
      Checkout.stub(:new).and_return(check_out)
      book = Book.create(isbn: "9781934356371", quantity: 2, quantity_left: 2)
      Book.stub(:find_by_isbn).and_return(book)
    end

    [5, 10, 12, 15].each do |num|
      context "#limit_checkouts(#{num})" do
        it "should limit number of checkouts to #{num}" do
          Checkout.stub(:count).and_return(4)
          subject.too_many_checkouts?(num, user).should be_false
        end
      end
    end

    it "redirects to the checkouts index" do
      create "check out"
      response.should redirect_to root_url
    end

    it "saves the checkout" do
      check_out.should_receive(:save)
      create "check out"
    end

    context "when the if there is a wait list and user cannot check out" do
      it "sets a flash[:notice] when there is a wait list" do
        subject.stub(:check_waitlist).and_return(false)
        create "check out"
        flash[:notice].should eq("There are people waiting on the waitinglist.")
      end
    end

    context "when there are too many checkouts" do
      it "sets a flash[:notice] for too many checkouts" do
        subject.stub(:too_many_checkouts?).and_return(true)
        create "check out"
        flash[:notice].should eq("too many checkouts")
      end
    end

    context "when the checkout is saved successfully" do
      it "sets a flash[:notice] checkout" do
        create "check out"
        flash[:notice].should eq("the checkout was successful")
      end
    end

    context "when the checkout is not saved" do
       it "sets a flash[:notice] checkout" do
         subject.stub(:unique?).and_return(false)
         create "check out"
         flash[:notice].should eq("Sorry, book is unavailable.")
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
