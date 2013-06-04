Given /^a reader$/ do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:google_oauth2,
                           {:uid => '123',
                            :provider => 'google_oauth2',
                            :info => {:name => "Taka Goto"}})
  visit root_path
  click_link 'sign in with Google'
end

Given /^there is a book called "(.*?)" with quantity (\d+)$/ do |book, quant|
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 1)
  @book.get_attr("title").should == book
end

When /^the reader checks out the book "(.*?)"$/ do |book|
  visit book_path("9781937557027")
  click_link "Check out"
end

Then /^the book is checked out$/ do
  Checkout.where(:user_id => 1, :book_id => 1)[0].should_not be_nil
end

