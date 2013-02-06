class RegisterBookController < ApplicationController
  def new
    @register_book = Book.new
  end

  def _form
  end
end
