Given(/^there is a book called "(.*?)"$/) do |arg1|
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 1)
  @book.get_attr("title").should == arg1
end

When(/^I already checked out the book$/) do
  Checkout.create(:user_id => 1, :book_id => 1)
end

When(/^I return the book$/) do
  visit return_book_path(@book.isbn)
end

Then(/^the book is available for anyone else to check out$/) do
  @book.quantity_left.should_not be(0)
end
