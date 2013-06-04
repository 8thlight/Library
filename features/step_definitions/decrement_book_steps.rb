Given /^I am a "([^\"]*)"$/ do |librarian|
  auth = { 'provider' => 'google_oauth2',
           'uid' => '0191092u09j',
           'info' => {'name' => 'taka', 'email' => 'tak.yuki@gmail.com'}}

  User.create_with_omniauth(auth).should be_true
end

Given /^There is a book "Mobile First"$/ do
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 1)
end

When /^I decrement the book "Mobile First"$/ do
  visit edit_book_path("9781937557027")
  fill_in "book_quantity", :with => 0
  click_button "submit_button"
end

Then /^The quantity should be 0$/ do
  book = Book.where(:isbn => "9781937557027")[0]
  book.quantity_left.should == 0
end
