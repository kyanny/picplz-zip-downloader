class Pic < ActiveRecord::Base
  attr_accessible :archived, :downloaded, :url, :user_id
  belongs_to :user

  def download
    return if self.downloaded
    open(self.url){ |image|
      workdir = Rails.root.join('tmp', user.nickname)
      FileUtils.mkdir_p(workdir) unless Dir.exists?(workdir)
      file = workdir.join(self.pic_id.to_s).to_s + '.jpg'
      open(file, 'wb'){ |f|
        f.write image.read
        Rails.logger.info("download from #{self.url}")
      }
    }
    self.downloaded = true
    self.save!
  end

  def self.archive(user_id)
    user = User.find(user_id)
    user.pics.each do |pic|
      pic.download
    end
    # zip
  end
end
