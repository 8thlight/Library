class Book < ActiveRecord::Base
  attr_accessible :isbn, :quantity

  validates :isbn, :length => {
    :maximum => 17,
    :minimum => 10
  }

  validate :validate_isbn
  validates :isbn, :uniqueness => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  def get_title
    GoogleBooks.search("#{isbn}").first.title
  end

  def get_author
    GoogleBooks.search("#{isbn}").first.authors
  end

  def get_image
    GoogleBooks.search("#{isbn}").first.image_link
  end

  def check_isbn
    GoogleBooks.search("#{isbn}").first != nil
  end

  def validate_isbn
    if check_isbn != true
      errors.add(:isbn, 'error on isbn')
      return false
    end
  end
end

