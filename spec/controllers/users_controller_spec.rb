require 'spec_helper'

describe BooksController do

  describe "Check-out" do
    it "should let a user check out a book" do
        user = mock_model(User).as_null_object
        book = mock_model(Book).as_null_object
        @book_attrs = {isbn: "9781935182474",
                       quantity: 2,
                       quantity_left: 2
                      }
        post :create, {book: @book_attrs}
        user.books.count.should_not == 0
    end
  end
end
