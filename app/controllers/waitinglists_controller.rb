class WaitinglistsController < ApplicationController
  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @wait = Waitinglist.new(book_id: @book_id, user_id: session[:user_id], wait_since: Time.now)
    if @book.quantity_left == 0 && user_new_in_list?(session[:user_id], @book_id)
      @wait.save
      flash[:notice] = "Added to the waiting list"
    else
      flash[:notice] = "Sorry, you can not be added to the waiting list"
    end
    redirect_to root_path
  end

  def user_new_in_list?(user, book)
    Waitinglist.where(user_id: session[:user_id], book_id: book).empty? &&
    Checkout.where(user_id: session[:user_id], book_id: book).empty?
  end
end
