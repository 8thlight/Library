class Book < ActiveRecord::Base
  include ApplicationDecorator
  has_many :checkouts
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

  API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"

  def get_attr(attr)
    BookDecorator.get_book_attr(isbn, attr)
  end

  def api_book
    @api_book ||= BookDecorator.get_google_book(isbn)
  end

  def validate_isbn
    if api_book.empty?
       errors.add(:isbn, 'does not exist')
       return false
    else
      return true
    end
  end
end

