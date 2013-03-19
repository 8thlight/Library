class ReturnController < ApplicationController
  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @checkout = Checkout.where(book_id: @book_id, user_id: session[:user_id])
    if @checkout.any?
      Checkout.destroy(@checkout)
      increment_quantity(@book)
      flash[:notice] = "Succesfully returned book."
      notify_if_waitlist(@book_id, session[:user_id])
    else
      flash[:notice] = "Could not return book."
    end
    redirect_to root_path
  end

  def increment_quantity(book)
    book.quantity_left += 1
    book.update_attributes(params[:book])
  end

  def notify_if_waitlist(book_id, user_id)
    if Waitinglist.where(book_id: book_id).first
      ReturnMailer.notify_book_available(current_user).deliver
    end
  end
end
