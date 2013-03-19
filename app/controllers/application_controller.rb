class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :user_signed_in?, :correct_user?,
                :book_not_checked_out?

  def too_many_checkouts?(num, user_id)
    Checkout.where(user_id: user_id).count >= num
  end

  def book_not_checked_out?(book)
    Checkout.where(user_id: current_user.id, book_id: book.id).empty?
  end

  def not_on_waiting_list?(book)
    Waitinglist.where(user_id: current_user.id, book_id: book.id).empty?
  end

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
