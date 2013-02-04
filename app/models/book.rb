class Book < ActiveRecord::Base
  attr_accessible :author, :isbn, :quantity, :title
end
