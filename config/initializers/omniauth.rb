Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "591777256334-gt5vj63osmoa0moc6r49a68loabukaot.apps.googleusercontent.com",
                           "RIIrBNUQs0b3T6zJNSXPWH-f"
end
