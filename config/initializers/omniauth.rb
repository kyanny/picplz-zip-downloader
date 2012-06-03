Rails.application.config.middleware.use OmniAuth::Builder do
  provider :picplz, ENV["PICPLZ_CONSUMER_KEY"], ENV["PICPLZ_CONSUMER_SECRET"]
end
