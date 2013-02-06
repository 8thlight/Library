class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to @book
    else
      p @book.errors
      render 'new'
    end
  end

  def show
  end
end
