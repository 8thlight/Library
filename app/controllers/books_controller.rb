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

  def show
    @book = Book.find_by_isbn(params[:isbn])
    @book_history = []
    @users_borrowed = {}
    @name = []
    @date = []
    Checkout.all.each do |check_outs|
      @book_history << check_outs if check_outs.book_id == @book.id
    end

    @book_history.each do |book_history|
      @users_borrowed[(User.find_by_id(book_history.user_id).name)] = book_history.check_out_date
    end
  end

  def edit
    @book = Book.find_by_isbn(params[:isbn])
  end

  def update
    @book = Book.find_by_isbn(params[:isbn])
    @book.quantity_left += ((params[:book][:quantity].to_i) - @book.quantity)
    @book.update_attributes(params[:book])
      redirect_to :action => "show"
  end
end
