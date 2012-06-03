class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  has_many :pics
  has_one :archive

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

  def picplz_user_api_url_base(last_pic_id=nil)
    url = "http://api.picplz.com/api/v2/user.json?id=#{self.uid}&include_pics=1&oauth_token=#{self.token}"
    if last_pic_id
      url = "#{url}&last_pic_id=#{last_pic_id}"
    end
    url
  end

  def get_pics_info(last_pic_id=nil)
    url = picplz_user_api_url_base(last_pic_id)

    open(url){ |f|
      res = JSON.parse(f.read)
      res['value']['users'][0]['pics'].each_with_index do |pic_data, index|
        Pic.create_with_user_and_pic_data(self, pic_data)
      end

      if res['value']['users'][0]['more_pics']
        last_pic_id = res['value']['users'][0]['last_pic_id']
        self.get_pics_from_picplz(last_pic_id)
      end
    }
  end
end
