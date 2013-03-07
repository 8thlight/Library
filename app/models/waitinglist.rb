class Waitinglist < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  attr_accessible :book_id, :user_id, :wait_since
end
