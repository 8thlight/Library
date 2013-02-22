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

  def check_out
    #@book = Book.find_by_isbn(params[:isbn])
    #flash[:notice] = "Sorry, that book  is unavailable to be checked out."

    @book = Book.find_by_isbn(params[:isbn])
    @user_id = User.find_by_id(session["warden.user.user.key"][1]).id
    @check_out = CheckOut.new(book_id: @book.id, user_id: @user_id, check_out_date: Time.now)
    if @check_out.save
      @book.quantity_left -= 1
      @book.update_attributes(params[:book])
      flash[:notice] = "Checked out #{@book.get_title} successfully!"
    else
      flash[:notice] = "Sorry, #{@book.get_title} is unavailable to be checked out."
    end
  end

  def show
    @book = Book.find_by_isbn(params[:isbn])
    @book_history = []
    @users_borrowed = {}
    CheckOut.all.each do |check_outs|
      @book_history << check_outs if check_outs.book_id == @book.id
    end

    @book_history.each do |book|
      @users_borrowed[User.find_by_id(book.user_id).name] = book.check_out_date
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
