class StaticController < ApplicationController
  def index
    @books = Book.all
  end
end
