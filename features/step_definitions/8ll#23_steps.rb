Given /^there is one book called "The Great Gatsby"$/ do
  Book.create(isbn: "9781934356371", quantity_left: 1)
end

When /^hundred users check out the book at the same time$/ do
end

Then /^one of the hundred users should be able to check out the book$/ do
end

And /^the other ninety-nine users should receive a message that the book is already checked out$/ do
end

Then /^the quantity is 0, not a negative number$/ do
end
