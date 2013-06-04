Given /^I am a Librarian$/ do
  auth = { 'provider' => 'google_oauth2',
           'uid' => '0191092u09j',
           'info' => {'name' => 'taka', 'email' => 'tak.yuki@gmail.com'}}

  User.create_with_omniauth(auth).should be_true
end

Given /^There is a book "Mobile First" with quantity 1$/ do
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 1)
end

When /^I increment the quantity of the book "Mobile First"$/ do
  visit edit_book_path("9781937557027")
  fill_in "book_quantity", :with => 2
  click_button "submit_button"
  page.should have_content @book.isbn
end

Then /^the quantity should be 2$/ do
  book = Book.where(:isbn => "9781937557027")[0]
  book.quantity_left.should == 2
end


