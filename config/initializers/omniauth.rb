require 'openid/store/filesystem'
require 'omniauth-openid'
require 'gapps_openid'
require 'openid'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '335035053762.apps.googleusercontent.com', 'S_OlytRvBhkz0AF6xTjKzHh2',
            {access_type: 'online', approval_prompt: ''}
    provider :open_id, :name => 'admin',
             :identifier => 'https://www.google.com/accounts/o8/site-xrds?hd=8thlight.com',
             :store => OpenID::Store::Filesystem.new('/tmp')
end
