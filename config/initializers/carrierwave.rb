CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],
    :aws_secret_access_key  => ENV['AWS_SECRET_KEY']
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'public, max-age=31557600'}
  config.fog_authenticated_url_expiration = 31557600
end