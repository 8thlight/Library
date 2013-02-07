class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:success] = "The book was saved successfully"
      redirect_to :action => "index"
    else
      flash[:error] = "Please fill in the fields correctly"
      render :action => "new"
    end
  end

  def show
  end
end
