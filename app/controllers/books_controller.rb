class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    #@books = Book.order("title ASC")
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
    @book = Book.find_by_isbn(params[:isbn])
  end

  def edit
    @book = Book.find_by_isbn(params[:isbn])
  end

  def update
    @book = Book.find(params[:id])

    @book.update_attributes(params[:book])
      redirect_to :action => "index"
  end
end
