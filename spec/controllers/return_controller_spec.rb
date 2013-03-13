require 'spec_helper'

describe ReturnController do

  describe "POST create" do
    let(:check_out) {mock_model(Checkout)}
    before do
      book = mock_model(Book)
      book.stub(:isbn).and_return("9781934356371")
    end

    it "redirects to the root path" do
      create "return"
      response.should redirect_to root_path
    end

    context "when there are no checkouts" do
      it "destroys the checkout history" do
        check_out.stub(:any?).and_return(false)
        create "return"
        flash[:notice].should == "Could not return book."
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
