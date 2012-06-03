class Archive < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user

  def archive
    get_pics_info
    download_pics
    create_zip
    store_to_s3
    self.update_attributes(:available => true)
  end

  def get_pics_info
    user.get_pics_info
  end

  def download_pics
    user.pics.each do |pic|
      pic.download
    end
  end

  def create_zip
    workdir = Rails.root.join('tmp', user.nickname)
    @zip     = "#{workdir}.zip"
    Zip::Archive.open(@zip, Zip::CREATE) do |ar|
      Dir.glob("#{workdir}/*.jpg").each do |jpg|
        ar.add_file(jpg)
      end
    end
  end

  def store_to_s3
    s3_name = "#{user.id}_picplz_#{File.basename(@zip)}"
    AWS::S3::S3Object.store(s3_name, open(@zip), 'picplz-zip-de-kure', {
        :content_type         => 'application/zip',
        :access               => :public_read,
        'x-amz-storage-class' => 'REDUCED_REDUNDANCY',
      })
    public_url = AWS::S3::S3Object.url_for(s3_name, 'picplz-zip-de-kure', { :authenticated => false })
    Rails.logger.info("stored to #{public_url}")
  end
end
