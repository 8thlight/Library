class User < ActiveRecord::Base
  has_many :checkouts
  has_many :books, :through => :checkouts
  attr_accessible :email, :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end
  end
end
