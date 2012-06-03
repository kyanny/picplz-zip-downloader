class Pic < ActiveRecord::Base
  attr_accessible :archived, :downloaded, :url, :user_id
end
