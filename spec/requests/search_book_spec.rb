require 'spec_helper'

describe 'search book' do
  describe 'by isbn' do
    it 'returns a book by isbn' do
      wrong_book = Book.create(:isbn => "9780321584106", :quantity => 1)
      book = Book.create!(:isbn => '9781934356371', :quantity => 1)
      post '/search', {:search_book => book.isbn}
      response.status.should be 200
      assigns[:results].should include(book)
      assigns[:results].should_not include(wrong_book)
    end
  end
end
