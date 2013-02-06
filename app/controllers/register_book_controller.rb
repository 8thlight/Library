class RegisterBookController < ApplicationController
  def new
    @book = Book.new
  end

  def _form
  end
end
