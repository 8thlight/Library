class CheckoutsController < ApplicationController

  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @check_out = Checkout.new(book_id: @book_id, user_id: session[:user_id], check_out_date: Time.now)
    if unique?(@check_out) && @check_out.save && @book.quantity_left > 0
      decrement_quantity(@book)
      flash[:notice] = "the checkout was successful"
    else
      flash[:notice] = "Sorry, #{@book.get_title} is unavailable. You may have already checkout this book."
    end
    redirect_to :action => "index"
  end

  def decrement_quantity(book)
    book.quantity_left -= 1
    book.update_attributes(params[:book])
  end

  def unique?(checkout)
    unique = true
    Checkout.all.each do |checkouts|
      unique = checkout.user_id == checkouts.user_id && checkout.book_id == checkouts.book_id ? false : true
    end
    unique
  end
end
