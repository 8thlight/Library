require 'spec_helper'

RSpec.configure do |c|
  c.exclusion_filter = { :slow_tests => false }
end

def create_check_out
  post :create, {:isbn => "9781934356371"}
end

describe CheckoutsController, :slow_tests => true do
  let (:check_out) {mock_model(Checkout).as_null_object}
  let (:book) {mock_model(Book).as_null_object}

  describe "verify unique checkout" do
    it "validates that a user can only checkout one copy of a book" do
      Checkout.create(book_id: 1, check_out_date: Time.now, user_id: 1)
      checkout2 = Checkout.new(book_id: 1, check_out_date: Time.now, user_id: 1)
      subject.unique?(checkout2).should be_false
    end
  end

  describe "POST create" do
    before do
      Checkout.stub(:new).and_return(check_out)
      book = Book.create(isbn: "9781934356371", quantity: 2, quantity_left: 2)
    end

    it "redirects to the checkouts index" do
      create_check_out
      response.should redirect_to(:action => "index")
    end

    it "saves the checkout" do
      check_out.should_receive(:save)
      create_check_out
    end

    context "when the checkout is saved successfully" do
      it "sets a flash[:notice] checkout" do
        create_check_out
        flash[:notice].should eq("the checkout was successful")
      end
    end

    context "when the checkout fails" do
      it "assigns @checkout" do
        check_out.stub(:save).and_return(false)
        create_check_out
        assigns[:check_out].should eq(check_out)
      end
    end
  end
end
