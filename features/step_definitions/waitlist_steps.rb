Given /^I am reader Taka$/ do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:google_oauth2,
                           {:uid => '123',
                            :provider => 'google_oauth2',
                            :info => {:name => "Taka"}})
  visit root_path
  click_link 'sign in with Google'
end

When(/^I view the "(.*?)" show page$/) do |arg1|
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 0)
  visit book_path('9781937557027')
end

When(/^the book is all checked out$/) do
  @book.quantity_left.should == 0
end

Then(/^I am able to add myself to the waiting list$/) do
  click_link "add myself to the waiting list"
  list = Waitinglist.where(:user_id => 1)[0]
  list.user.name.should == "Taka"
end

When /^I click "Add myself to the waiting list"$/ do
  @book = Book.create(isbn: "9781937557027", quantity: 1, quantity_left: 0)
  visit book_path('9781937557027')
  click_link "add myself to the waiting list"
end

And /^there is a "(.*?)" book checked out$/ do |book|
  !Checkout.where(:book_id => 1)[0].nil?
end

And /^I am viewing the "(.*?)" show page$/ do |book|
  visit book_path('9781937557027')
end

Then(/^my name will appear at the top of the waiting list$/) do
  list = Waitinglist.where(:book_id => 1)
  list.first.user.name.should == "Taka"
end

