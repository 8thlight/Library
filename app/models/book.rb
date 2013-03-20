class Book < ActiveRecord::Base
  include RedisDecorator
  has_many :check_outs
  has_many :waitinglist
  has_many :users, :through => :checkouts
  has_many :users, :through => :waitinglist

  attr_accessible :isbn, :quantity, :quantity_left

  validates :isbn, :length => {
    :maximum => 17,
    :minimum => 10
  }

  validate :validate_isbn
  validates :isbn, :uniqueness => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
end

