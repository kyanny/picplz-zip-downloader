class Pic < ActiveRecord::Base
  attr_accessible :archived, :downloaded, :url, :user_id
  belongs_to :user

  def longurl_id
    url.split('/')[-1]
  end

  def download
    return if self.downloaded
    open(self.img_url){ |image|
      workdir = Rails.root.join('tmp', user.nickname)
      FileUtils.mkdir_p(workdir) unless Dir.exists?(workdir)
      file = workdir.join("picplz_#{self.longurl_id}").to_s + '.jpg'
      open(file, 'wb'){ |f|
        f.write image.read
        Rails.logger.info("download from #{self.img_url}")
      }
    }
    self.downloaded = true
    self.save!
  end
end
