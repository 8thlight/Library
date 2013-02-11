require 'spec_helper'

describe "books/index.html.erb" do
  it "displays the text 'List of Books'" do
    @books = []
    render
    rendered.should contain("List of Books")
  end
end
