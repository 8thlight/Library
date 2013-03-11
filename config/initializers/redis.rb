$redis = Redis.new(:host => 'localhost', :port => 6379)

#uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")

redis_url = ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379/0/myapp"
Library::Application.config.cache_store = :redis_store, redis_url
Library::Application.config.session_store :redis_store, redis_server: redis_url
REDIS = Redis.new(:host => redis_url.host, :port => redis_url.port, :password => redis_url.password)