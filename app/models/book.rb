class Book < ActiveRecord::Base
  has_and_belongs_to_many :user
  attr_accessible :isbn, :quantity, :quantity_left

  validates :isbn, :length => {
    :maximum => 17,
    :minimum => 10
  }

  validate :validate_isbn
  validates :isbn, :uniqueness => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"

  def get_title
    google_book.title
  end

  def get_author
    google_book.authors
  end

  def get_image
    google_book.image_link
  end

  def check_isbn
    google_book.isbn != nil
  end

  def validate_isbn
    if check_isbn != true
      errors.add(:isbn, 'does not exist')
      return false
    end
  end

  private

  def google_book
    @google_book ||= GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first
  end
end

