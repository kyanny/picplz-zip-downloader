AWS::S3::Base.establish_connection!(
  :access_key_id     => ENV['ACCESS_KEY_ID'],
  :secret_access_key => ENV['SECRET_ACCESS_KEY'],
  )
