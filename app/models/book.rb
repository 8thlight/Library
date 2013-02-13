class Book < ActiveRecord::Base
  attr_accessible :isbn, :quantity

  validates :isbn, :length => {
    :maximum => 17,
    :minimum => 10
  }
  validates :isbn, :uniqueness => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
end
