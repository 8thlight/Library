class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(params[:book])
    @book.quantity_left = @book.quantity
    require 'pry'
    if @book.save
      flash[:success] = "The book was saved successfully"
      redirect_to :action => "index"
    else
      flash[:error] = "Please fill in the fields correctly"
      render :action => "new"
    end
  end

  def check_out
    @book = Book.find_by_isbn(params[:isbn])
    if @book.quantity_left > 0
      @book.quantity_left -= 1
      @book.update_attributes(params[:book])
      @book.user << User.find(session["warden.user.user.key"][1])
      flash[:notice] = "Checked out successfully!"
    else
      flash[:notice] = "Sorry, that book is unavailable to be checked out."
    end
  end

  def show
    @book = Book.find_by_isbn(params[:isbn])
  end

  def edit
    @book = Book.find_by_isbn(params[:isbn])
  end

  def update
    @book = Book.find_by_isbn(params[:isbn])
    @book.quantity_left += ((params[:book][:quantity].to_i) - @book.quantity)
    require 'pry'
    binding.pry
    @book.update_attributes(params[:book])
      redirect_to :action => "show"
  end
end
