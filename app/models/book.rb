class Book < ActiveRecord::Base
  attr_accessible :author, :isbn, :quantity, :title

  validates :title, :presence => true,  :uniqueness => true
  validates :isbn, :presence => true, :uniqueness => true
  validates :author, :presence => true
  validates :quantity, :presence => true
end
