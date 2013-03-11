$redis = Redis.new(:host => 'localhost', :port => 6379)

#uri = URI.parse(ENV["REDISTOGO_URL"])

uri = Redis.connect(:url => ENV['REDISTOGO_URL'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

