class BookAPI

  API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"

  def self.find(isbn)
    GoogleBooks.search(isbn.to_s, :api_key => API_KEY).first
  end
end
