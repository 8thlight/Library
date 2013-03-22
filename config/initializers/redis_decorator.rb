module ApplicationDecorator
  class BookDecorator
    API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"
    CACHE_EXPIRE = 1.months

    def self.get_book_attr(isbn, attr)
      add_book_to_redis(isbn) if REDIS.hlen("isbn_#{isbn}").zero?
      REDIS.hget("isbn_#{isbn}", attr)
    end

    def self.get_google_book(isbn)
      add_book_to_redis(isbn) if REDIS.hlen("isbn_#{isbn}").zero?
      REDIS.hgetall("isbn_#{isbn}")
    end

    def self.book(isbn)
      @book ||= GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first
    end

    private

    def self.add_book_to_redis(key)
      if !book.nil?
        REDIS.hmset("isbn_#{key}", "title", book.title, "author", book.authors, "image", book.image_link)
        REDIS.expire(key,  CACHE_EXPIRE)
      end
    end
  end
end
