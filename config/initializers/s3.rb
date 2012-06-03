AWS::S3::Base.establish_connection!(
  :access_key_id     => ENV['ACCESS_KEY_ID'],
  :secret_access_key => ENV['SECRET_ACCESS_KEY'],
  )
PicplzZipDeKure::Application.config.s3_bucket_name = 'picplz-zip-de-kure'
AWS::S3::Bucket.create(PicplzZipDeKure::Application.config.s3_bucket_name)
