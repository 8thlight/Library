require 'spec_helper'

describe "books/index.html.erb" do
  it "displays the text 'List of Books'" do
    render
    rendered.should contain("List of Books")
  end

  describe "the list of books" do
    #book1 = Book.new(title: "rspec book",
    #                    author: "Michael Hartl",
    #                    isbn: "1234567892",
    #                    quantity: 2)
    xit {should have_content(book1.title)}
    #it {should have_content(book1.author)}
    #it {should have_content(book1.isbn)}
    #it {should have_content(book1.quantity)}
  end
end
