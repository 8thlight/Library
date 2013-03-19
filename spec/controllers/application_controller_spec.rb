require 'spec_helper'

describe ApplicationController do
  describe "#correct_user?" do
    it "checks if the user is correct" do
      User.should_receive(:find)
      subject.correct_user?
    end
  end

  describe "#book_not_checked_out?" do
    it "should check if the book is not checked out by current user" do
      @current_user = mock_model(User, :id => 1)
      book = mock_model(Book, :id => 1)
      controller.stub(:current_user).and_return(@current_user)
      subject.book_not_checked_out?(book).should be_true
    end
  end

  describe "#not_on_waiting_list?" do
     it "should check if the user is on the waiting list for the book" do
      @current_user = mock_model(User, :id => 1)
      controller.stub(:current_user).and_return(@current_user)
      book = mock_model(Waitinglist, :id => 1)
      subject.not_on_waiting_list?(book)
     end
  end
end
