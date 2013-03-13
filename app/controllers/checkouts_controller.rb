class CheckoutsController < ApplicationController

  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @check_out = Checkout.new(book_id: @book_id, user_id: session[:user_id], check_out_date: Time.now)
    @user_id =  User.find(session[:user_id]).id

    if unique?(@check_out) && !@book.quantity_left.zero? && check_waitlist(@book_id, @user_id)
      @check_out.save
      decrement_quantity(@book)
      flash[:notice] = "the checkout was successful"
    else
      flash[:notice] = "Sorry, book is unavailable. You may have already checkout this book."
    end
    redirect_to :action => "index"
  end

  def unique? checkout
    Checkout.all.all? { |checkouts| checkout.user_id != checkouts.user_id && checkout.book_id != checkouts.book_id }
  end

  def check_waitlist(book_id, user_name)
    if Waitinglist.where(book_id: book_id).empty?
      return true
    else
      if check_first_waitlist(book_id, user_name)
        remove_from_waitinglist(book_id)
        return true
      else
        return false
      end
    end
  end

  def remove_from_waitinglist(book_id)
    remove_from_waiting_list = Waitinglist.where(book_id: book_id).first
    Waitinglist.destroy(remove_from_waiting_list)
  end

  def check_first_waitlist(book_id, user_id)
    @waiting_list = Waitinglist.where(book_id: book_id).first
    return true if @waiting_list != nil && @waiting_list.user.id == user_id
    false
  end
end





