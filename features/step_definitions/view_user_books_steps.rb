When(/^the reader looked at the books I have checked out$/) do
  visit mybooks_path
end

When(/^the reader has checked out the book "(.*?)"$/) do |arg1|
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 1)
  @book1 = Book.create(isbn: "9780321601667", quantity: 1, quantity_left: 1)
  @book.get_attr("title").should == "Mobile first"
  @book1.get_attr("title").should == "The Rails 3 Way"
  Checkout.create(:user_id => 1, :book_id => 1)
  Checkout.create(:user_id => 1, :book_id => 2)
end

Then(/^I see "(.*?)"$/) do |arg1|
  visit mybooks_path
  page.should have_content @book.get_attr("title")
  page.should have_content @book1.get_attr("title")
end
