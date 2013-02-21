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
    if @book.save
      flash[:success] = "The book was saved successfully"
      redirect_to :action => "index"
    else
      flash[:error] = "Please fill in the fields correctly"
      render :action => "new"
    end
  end

  #remember to insert flash notice when user can't check out
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
    @book.update_attributes(params[:book])
      redirect_to :action => "show"
  end
end
