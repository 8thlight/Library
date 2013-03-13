require 'spec_helper'

describe WaitinglistsController do
  let (:waiting_list) {mock_model(Waitinglist).as_null_object}

  before(:each) do
    Waitinglist.stub(:new).and_return(waiting_list)
    book = Book.create(isbn: "9781934356371", quantity: 2, quantity_left: 0)
  end

  describe "POST create" do
    it "redirects to root path" do
      create "waiting list"
      response.should redirect_to root_path
    end

    it "adds to waiting list" do
      waiting_list.should_receive(:save)
      create "waiting list"
    end

    context "when the user is added successfully to the wait list" do
      it "sets a flash[:notice]" do
        book = mock_model(Book)
        create "waiting list"
        flash[:notice].should eq("Added to the waiting list")
      end
    end

    context "when the user is not added to the waiting list" do
       it "sets a flash[:notice]" do
         subject.stub(:user_new_in_list?).and_return(false)
         create "waiting list"
         flash[:notice].should eq("Sorry, you can not be added to the waiting list")
       end
    end
  end
end
