require 'spec_helper'

describe User do
  it { should have_many(:checkouts) }
  it { should have_many(:waitinglist) }
  it { should have_many(:books).through(:waitinglist) }

  describe "#create_with_omniauth" do
    it "should create a user using omniauth" do
      auth = { 'provider' => 'google_oauth2',
               'uid' => '0191092u09j',
               'info' => {'name' => 'taka', 'email' => 'tak.yuki@gmail.com'}
      }
      User.create_with_omniauth(auth).should be_true
    end

    it "should have attributes" do
      auth = { 'provider' => 'google_oauth2',
               'uid' => '0191092u09j',
               'info' => {'name' => 'taka', 'email' => 'tak.yuki@gmail.com'}
      }
      user = User.create_with_omniauth(auth)
      user.email.should == "tak.yuki@gmail.com"
      user.name.should == "taka"
      user.uid.should == '0191092u09j'
      user.provider.should == 'google_oauth2'
    end
  end
end
