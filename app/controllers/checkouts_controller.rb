class CheckoutsController < ApplicationController

  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @check_out = Checkout.new(book_id: @book_id, user_id: session[:user_id], check_out_date: Time.now)
    @user_name =  User.find(session[:user_id]).name

    mutex = Mutex.new

    if unique?(@check_out) && !@book.quantity_left.zero? && check_waitlist(@book_id, @user_name)
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

  def remove_from_waitinglist(book_id)
    remove_from_waiting_list = Waitinglist.where(book_id: book_id).first
    Waitinglist.destroy(remove_from_waiting_list)
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

  def check_first_waitlist(book_id, user_name)
    @waiting_list = Waitinglist.where(book_id: book_id).first
    return true if @waiting_list != nil && @waiting_list.user.name == user_name
    false
  end
end





