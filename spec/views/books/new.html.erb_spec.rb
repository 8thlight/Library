require 'spec_helper'

describe "books/new.html.erb" do
  let (:book) do
    mock_model("Book").as_new_record.as_null_object
  end

  before do
    assign(:book, book)
  end

  it "displays the text 'Register Book" do
    render
    rendered.should contain("Book")
  end

  it "renders a form to create a message" do
    render
    rendered.should have_selector("form",
                                  :method => "post",
                                  :action => books_path
                                 ) do |form|
                                   form.should have_selector("input", :type => "submit")
                                 end
  end
  {
    :title => "Rails Tutorial",
    :author => "Michael Hartl",
    :isbn => "1234567890"
  }.each do |attr, value|
    it "renders a text field for #{attr}" do
      book.stub(attr => value)
      render
      rendered.should have_selector("form") do |form|
        form.should have_selector("input",
                                  :type => "text",
                                  :name => "book[#{attr}]",
                                  :value => value
                                 )
      end
    end
  end

  it "renders labels" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("label")
    end
  end
end
