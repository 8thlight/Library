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
      redirect_to root_path
    else
      flash[:error] = "Please fill in the fields correctly"
      render :action => "new"
    end
  end

  def mybooks
    @book_ids = []
    @checkouts = Checkout.where(user_id:session[:user_id])
    @checkouts.each do |checkout|
      @book_ids << checkout.book_id
    end
    @book_titles = []
    @book_ids.each do |book_id|
      book = Book.find_by_id(book_id)
      @book_titles << book.get_title
    end
  end

  def show
    @book = Book.find_by_isbn(params[:isbn])
    @users_borrowed = {}
    @checked_out_books = Checkout.where(book_id: @book.id)

    checked_out(@checked_out_books, @users_borrowed) unless @checked_out_books.empty?
  end

  def checked_out(books, users)
    books.each do |book|
      users[book.user.name] = book.check_out_date
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
