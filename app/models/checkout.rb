class Checkout < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  attr_accessible :book_id, :check_out_date, :user_id
end
