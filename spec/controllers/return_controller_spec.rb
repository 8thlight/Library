require 'spec_helper'

describe ReturnController do

  describe "POST create" do
    before do
      book = mock_model(Book)
      book.stub(:isbn).and_return("9781934356371")
      check_out = mock_model(Checkout)
      check_out.stub(:any?).and_return(true).as_null_object
    end

    it "redirects to the root path" do
      post :create, {:isbn => "9781934356371"}
      response.should redirect_to root_path
    end

    it "destroys the checkout history" do
    end

    context "when the return is successful" do
    end
  end
end
