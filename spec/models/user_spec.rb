require 'spec_helper'

describe User do
  describe "#create_with_omniauth" do
    it "should create a user using omniauth" do
      auth = { 'provider' => 'google_oauth2',
               'uid' => '0191092u09j',
               'info' => {'name' => 'taka', 'email' => 'tak.yuki@gmail.com'}
      }
      User.create_with_omniauth(auth).should be_true
    end
  end
end
