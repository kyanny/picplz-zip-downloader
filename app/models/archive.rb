class Archive < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user

  def self.archive(user_id)
    user = User.find(user_id)
    user.pics.each do |pic|
      pic.download
    end

    workdir = Rails.root.join('tmp', user.nickname)
    zip     = "#{workdir}.zip"
    Zip::Archive.open(zip, Zip::CREATE) do |ar|
      Dir.glob("#{workdir}/*.jpg").each do |jpg|
        ar.add_file(jpg)
      end
    end

    s3_name = "#{user.id}_picplz_#{File.basename(zip)}"
    AWS::S3::S3Object.store(s3_name, open(zip), 'picplz-zip-de-kure', {
        :content_type => 'application/zip',
        :access => :public_read,
        'x-amz-storage-class' => 'REDUCED_REDUNDANCY',
      })
    public_url = AWS::S3::S3Object.url_for(s3_name, 'picplz-zip-de-kure', { :authenticated => false })
    Rails.logger.info("stored to #{public_url}")
  end
end
