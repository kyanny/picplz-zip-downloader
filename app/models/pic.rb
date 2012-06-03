class Pic < ActiveRecord::Base
  attr_accessible :archived, :downloaded, :url, :user_id
  belongs_to :user

  def longurl_id
    url.split('/')[-2]
  end

  def download
    return if self.downloaded
    open(self.url){ |image|
      workdir = Rails.root.join('tmp', user.nickname)
      FileUtils.mkdir_p(workdir) unless Dir.exists?(workdir)
      file = workdir.join(self.longurl_id).to_s + '.jpg'
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

    workdir = Rails.root.join('tmp', user.nickname)
    zip     = "#{workdir}.zip"
    Zip::Archive.open(zip, Zip::CREATE) do |ar|
      Dir.glob("#{workdir}/*.jpg").each do |jpg|
        Rails.logger.debug(jpg)
        ar.add_file(jpg)
      end
    end
  end
end
