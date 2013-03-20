module RedisDecorator

  API_KEY = "AIzaSyAqerTH3Ee8TcKFLn695LAu8HQm9SBFrn0"
  uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

  def get_attr(attr)
    if REDIS.get("#{isbn}_#{attr}").nil?
      google_attribute = google_data(attr)
      add_to_redis(google_attribute, attr)
      return google_attribute
    else
      REDIS.get("#{isbn}_#{attr}")
    end
  end

  def google_data(attr)
    return google_book.title if attr == "title"
    return google_book.authors if attr == "author"
    return google_book.image_link if attr == "image"
    nil
  end

  def check_isbn
    GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first != nil
  end

  def validate_isbn
    if check_isbn != true
       errors.add(:isbn, 'does not exist')
       return false
    else
      return true
    end
  end

  private

  def add_to_redis(title, attribute)
    REDIS.set("#{isbn}_#{attribute}", title)
    REDIS.expire("#{isbn}_#{attribute}", 2_500_000)
  end

  def google_book
    @google_book ||= GoogleBooks.search("isbn:#{isbn}", :api_key => API_KEY).first
  end
end
