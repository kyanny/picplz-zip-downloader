class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.nickname = auth['info']['nickname']
      user.url      = auth['info']['urls']['Picplz']
      user.image    = auth['info']['image']
    end
  end
end
