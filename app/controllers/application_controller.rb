class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :user_signed_in?, :correct_user?

  def user_new_in_list?(user, book)
    Waitinglist.where(user_id: session[:user_id], book_id: book).empty? &&
    Checkout.where(user_id: session[:user_id], book_id: book).empty?
  end

  def increment_quantity(book)
    book.quantity_left += 1
    book.update_attributes(params[:book])
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

  def check_first_waitlist(book_id, user_id)
    @waiting_list = Waitinglist.where(book_id: book_id).first
    return true if @waiting_list != nil && @waiting_list.user.id == user_id
    false
  end

  private

    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        rescue
          puts "I am rescued"
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end
end
