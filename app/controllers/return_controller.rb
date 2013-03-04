class ReturnController < ApplicationController
  def create
    @book = Book.find_by_isbn(params[:isbn])
    @book_id = @book.id if @book != nil
    @checkout = Checkout.where(book_id: @book_id, user_id: session[:user_id])
    if @checkout.any?
      Checkout.destroy(@checkout)
      increment_quantity(@book)
      flash[:notice] = "Succesfully returned book."
    else
      flash[:notice] = "Could not return book."
    end
    redirect_to root_path
  end

  def increment_quantity(book)
    book.quantity_left += 1
    book.update_attributes(params[:book])
  end
end
