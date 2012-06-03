class Archive < ActiveRecord::Base
  attr_accessible :user_id, :public_url, :available
  belongs_to :user

  before_destroy :delete_archive

  def bucket_name
    PicplzZipDeKure::Application.config.s3_bucket_name
  end

  def workdir
    Rails.root.join('tmp', user.nickname)
  end

  def zip
    "#{workdir}.zip"
  end

  def zip_name
    File.basename(zip)
  end

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
    Zip::Archive.open(zip, Zip::CREATE) do |ar|
      Dir.glob("#{workdir}/*.jpg").each do |jpg|
        ar.add_file(jpg)
      end
    end
  end

  def store_to_s3
    s3_name = "#{user.id}_picplz_#{zip_name}"
    AWS::S3::S3Object.store(s3_name, open(zip), bucket_name, {
        :content_type         => 'application/zip',
        :access               => :public_read,
        'x-amz-storage-class' => 'REDUCED_REDUNDANCY',
      })
    public_url = AWS::S3::S3Object.url_for(s3_name, bucket_name, { :authenticated => false })
    self.update_attributes(:public_url => public_url)
    Rails.logger.info("stored to #{public_url}")
  end

  def delete_archive
    AWS::S3::S3Object.delete(zip_name, bucket_name)
  end
end
