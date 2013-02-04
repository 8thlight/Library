class Book < ActiveRecord::Base
  attr_accessible :author, :isbn, :quantity, :title
  validates :title, :uniqueness => true
  validates :isbn, :uniqueness => true
end
