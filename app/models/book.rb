class Book < ActiveRecord::Base
  attr_accessible :author, :isbn, :quantity, :title

  validates :title, :presence => { :message => "Please enter a title" },  :uniqueness => true
  validates :isbn, :length => {
    :maximum => 17,
    :minimum => 10
  }
  validates :isbn, :uniqueness => true
  validates :author, :presence => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
end
