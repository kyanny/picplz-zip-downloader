class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.client_id = auth['client_id']
      user.display_name = auth['info']['display_name']
    end
  end
end
