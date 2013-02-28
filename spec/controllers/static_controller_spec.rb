require 'spec_helper'

describe StaticController do
  let (:book) {mock_model(Book).as_null_object}

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
 context "listing books" do
    it "assigns no books" do
    get :index
    assigns(:books).should == []
  end

    it "lists a created book" do
      book = Book.new(isbn: "9781934356548", quantity: 3)
      Book.should_receive(:all).and_return([book])
      get :index
      assigns(:books).should == [book]
    end
  end
end
