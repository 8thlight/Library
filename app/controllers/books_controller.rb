class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = "The book was saved successfully"
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def show
  end
end
