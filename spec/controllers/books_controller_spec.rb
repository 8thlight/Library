require 'spec_helper'

describe BooksController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    context "with correct attributes" do
      before do
        @attrs = {:title => "Moby Dick", :isbn => "1234567891", :author => "Hemmingway", :quantity => 10}
      end

      it "creates a book" do
        post :create, {:book => @attrs}
        Book.count.should_not == 0
      end
    end
  end

end
