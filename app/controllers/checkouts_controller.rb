class CheckoutsController < ApplicationController

  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @check_out = Checkout.new(book_id: @book_id, user_id: session[:user_id], check_out_date: Time.now)
    @user_id =  User.find(session[:user_id]).id

    mutex = Mutex.new

    if unique?(@check_out) && !@book.quantity_left.zero? && check_waitlist(@book_id, @user_id)
      @check_out.save
      mutex.synchronize do
        decrement_quantity(@book)
      end
      flash[:notice] = "the checkout was successful"
    else
      flash[:notice] = "Sorry, book is unavailable. You may have already checkout this book."
    end
    redirect_to :action => "index"
  end
end





