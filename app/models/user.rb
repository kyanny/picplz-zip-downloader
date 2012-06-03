class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.nickname = auth['info']['nickname']
      user.url      = auth['info']['urls']['Picplz']
      user.image    = auth['info']['image']
      user.token    = token_and_secret_from_auth_hash(auth)['oauth_token']
      user.secret   = token_and_secret_from_auth_hash(auth)['oauth_secret']
    end
  end

  def self.token_and_secret_from_auth_hash(auth)
    Hash[*auth['credentials']['token'].split('|').last.split('&').map{ |keyvalue| keyvalue.split('=') }.flatten]
  end
end



