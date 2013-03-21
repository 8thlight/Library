module ApplicationDecorator
  class BookDecorator
    API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"
    CACHE_EXPIRE = 1.months

    def self.get_book_attr(isbn, attr)
      add_object_redis(isbn, @book) if get_redis(isbn, attr).nil?
      get_redis(isbn, attr)
    end

    def self.get_google_book(isbn)
      if !REDIS.get(isbn)
        @book ||= GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first
        add_object_to_redis(isbn, @book)
      end
      get_book_json(isbn)
    end

    private

      def self.get_book_json(isbn)
        if REDIS.get(isbn)
          JSON.parse REDIS.get(isbn)
        end
      end

      def self.get_redis(key, attr)
        (JSON.parse REDIS.get(key))[attr]
      end

      def self.add_object_to_redis(key, value)
        if !value.nil?
          REDIS.set(key, value.to_json)
          REDIS.expire(key, CACHE_EXPIRE)
        end
      end
  end
end
