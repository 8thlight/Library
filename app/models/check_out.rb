class CheckOut < ActiveRecord::Base
  attr_accessible :book_id, :check_out_date, :user_id
  belongs_to :book
  belongs_to :user
end
