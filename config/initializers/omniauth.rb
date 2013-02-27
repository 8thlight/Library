Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '335035053762.apps.googleusercontent.com', 'S_OlytRvBhkz0AF6xTjKzHh2'
end
