class CheckoutsController < ApplicationController

  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @check_out = Checkout.new(book_id: @book_id, user_id: session[:user_id], check_out_date: Time.now)
    if @check_out.save && @book.quantity_left > 0
      decrement_quantity(@book)
      flash[:notice] = "the checkout was successful"
    else
      flash[:notice] = "Sorry, #{@book.get_title} is unavailable."
    end
    redirect_to :action => "index"
  end

  def decrement_quantity(book)
    @book.quantity_left -= 1
    @book.update_attributes(params[:book])
  end
#  def new
#    @book = Book.find_by_isbn(params[:isbn])
#    @user_id = User.find_by_id(session[:user_id]).id
#    @check_out = CheckOut.new(book_id: @book.id, user_id: @user_id, check_out_date: Time.now)
#  end
#
#  def check_out
#    if @check_out.save && @book.quantity_left > 0
#      @book.quantity_left -= 1
#      @book.update_attributes(params[:book])
#      flash[:notice] = "Checked out #{@book.get_title} successfully!"
#    else
#      flash[:notice] = "Sorry, #{@book.get_title} is unavailable to be checked out."
#    end
#  end
end
