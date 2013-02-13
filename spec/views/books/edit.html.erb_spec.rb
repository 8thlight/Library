require 'spec_helper'

describe "books/edit.html.erb" do

  xit "displays the correct isbn number" do
    book = mock_model("Book").as_new_record.as_null_object
    assign(:book, book)
    book.stub(:isbn => "978-1-93435-637-1")
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
                                :type => "text",
                                :name => "book[:ibsn]",
                                :value => "978-1-93435-637-1")
    end
  end
end
