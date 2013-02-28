require 'spec_helper'

describe CheckoutsController do
  let (:check_out) {mock_model(Checkout).as_null_object}
  let (:book) {mock_model(Book).as_null_object}

  before do
    Checkout.stub(:new).and_return(check_out)
  end

  describe "POST check_out" do
    xit "redirects to the checkouts index" do
      post :create
      response.should redirect_to(:action => "index")
    end

    xit "saves the checkout" do
      check_out.should_receive(:save)
      post :create
    end

    context "when the checkout is saved successfully" do
      xit "sets a flash[:notice] checkout" do
        post :create
        flash[:notice].should eq("Checked out #{@book.get_title} successfully!")
      end
    end

    context "when the checkout fails" do
      xit "assigns @checkout" do
        check_out.stub(:save).and_return(false)
        post :create
        assigns[:check_out].should eq(check_out)
      end
    end
  end
end
