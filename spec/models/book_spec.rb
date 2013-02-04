require 'spec_helper'

describe Book do
  #pending "add some examples to (or delete) #{__FILE__}"
  rspec_book = Book.new(title: "rspec book", author: "Taka Goto", isbn: "1234abcd", quantity: 2)
end
