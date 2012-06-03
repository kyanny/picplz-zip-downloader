
class WelcomeController < ApplicationController
  def index
  end

  def feed
    require 'open-uri'
    open("http://api.picplz.com/api/v2/user.json?id=#{current_user.uid}&include_pics=1"){ |f|
      logger.debug(f)
      data = f.read
      logger.debug(data)
      raise data
    }
  end
end
