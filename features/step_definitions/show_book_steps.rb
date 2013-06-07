Given(/^the reader has not checked out the book$/) do
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 1)
  Checkout.all.empty?.should be_true
end

When(/^the reader sees the show page for that book$/) do
  visit book_path(@book.isbn)
end

Then(/^the return and waiting list link should not appear\.$/) do
  page.should_not have_content("return")
  page.should_not have_content("add myself to the waiting list")
end
