CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider:               "AWS",
      aws_access_key_id:      ENV["aws_access_key_id"],
      aws_secret_access_key:  ENV["aws_secret_access_key"],
      region:                 ENV["aws_region"],
      host:                   ENV["aws_host"],
      endpoint:               ENV["aws_endpoint"],
      directory:              ENV["aws_directory"]
    }
    config.fog_public = false
  end
end
