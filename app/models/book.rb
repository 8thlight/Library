class Book < ActiveRecord::Base
  include GoogleBooks
  attr_accessible :isbn, :quantity

  validates :isbn, :length => {
    :maximum => 17,
    :minimum => 10
  }

  validate :validate_isbn
  validates :isbn, :uniqueness => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"

  def get_title
    GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first.title
  end

  def get_author
    GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first.authors
  end

  def get_image
    GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first.image_link
  end

  def check_isbn
    GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first != nil
  end

  def validate_isbn
    if check_isbn != true
      errors.add(:isbn, 'does not exist')
      return false
    end
  end

  #def get_google_api(attr)
  #  GoogleBooks.search("#{isbn}", options[:api_key] = API_KEY).first.attr
  #end
end

