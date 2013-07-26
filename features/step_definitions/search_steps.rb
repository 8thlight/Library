Given(/^there are multiple books$/) do
  Book.create(:isbn => "9780321584106", :quantity => 1)
  Book.create(:isbn => "9781934356371", :quantity => 1)
  Book.create(:isbn => "9780321601667", :quantity => 1)
end

When(/^I create a book Mobile First$/) do
  @book = Book.create(:isbn => "9781937557027", :quantity => 1)
end

When(/^I fill in the search bar with the isbn of Mobile First$/) do
  fill_in 'search_book', :with => @book.isbn
end

Then(/^the book "(.*?)" is displayed from isbn$/) do |arg1|
  visit root_path
  fill_in 'search_book', :with => @book.isbn
  click_button 'search'
  page.should have_content('Search Result')
  page.should have_content('Mobile first')
end


