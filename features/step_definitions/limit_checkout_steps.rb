When(/^I have (\d+) books checked out$/) do |arg1|
  Book.create(isbn: "9781937557027", quantity: 6, quantity_left: 6)
  Checkout.create(:user_id => 1, :book_id => 1)
  Checkout.create(:user_id => 1, :book_id => 1)
  Checkout.create(:user_id => 1, :book_id => 1)
  Checkout.create(:user_id => 1, :book_id => 1)
  Checkout.create(:user_id => 1, :book_id => 1)
  Checkout.where(:user_id => 1, :book_id => 1).count.should == 5
end

When(/^I try to checkout a (\d+)th book$/) do |arg1|
  Book.create(isbn: "9780321601667", quantity: 6, quantity_left: 6)
  visit book_path('9780321601667')
  click_link "Check out"
end

Then(/^I should get an error$/) do
  page.should have_content("too many checkouts")
end

