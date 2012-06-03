class Pic < ActiveRecord::Base
  attr_accessible :archived, :downloaded, :url, :user_id
  belongs_to :user

  def download
    open(self.url){ |image|
      workdir = Rails.root.join('tmp', user.uid)
      FileUtils.mkdir_p(workdir) unless Dir.exists?(workdir)
      open(workdir.join(self.id), 'w'){ |f|
        f.write image.read
      }
    }
    self.downloaded = true
    self.save!
  end
end
