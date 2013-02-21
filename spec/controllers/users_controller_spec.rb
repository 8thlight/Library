require 'spec_helper'

describe BooksController do

  describe "Check-out" do
    xit "should let a user check out a book" do
        user = mock_model(User).as_null_object
        book = mock_model(Book).as_null_object
        @user_attrs = { :email => 'anishkothari@gmail.com',
                   :password => 'hello',
                   :password_confirmation => 'hello'
                }
        @book_attrs = {isbn: "9781935182474",
                       quantity: 2,
                       quantity_left: 2
                      }
        post :check_outs, {book: @book_attrs}
        user.books.count.should_not == 0
    end
  end
end
