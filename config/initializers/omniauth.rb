Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['IW_FACEBOOK_KEY'], ENV['IW_FACEBOOK_SECRET'], {:scope => 'publish_stream,email'}
  provider :twitter, ENV['IW_TWITTER_KEY'], ENV['IW_TWITTER_SECRET']
end