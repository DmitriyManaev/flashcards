CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider:               "AWS",
      aws_access_key_id:      ENV["aws_access_key_id"],
      aws_secret_access_key:  ENV["aws_secret_access_key"],
      region:                 "us-east-1",
      host:                   "s3-website-us-east-1.amazonaws.com",
      endpoint:               "http://s3-website-us-east-1.amazonaws.com"
    }
    config.fog_directory  = "myfilesflash"
    config.fog_public     = false
  end
end
