CarrierWave.configure do |config|
  if !Rails.env.test? && !Rails.env.development?
    config.storage = :fog
    config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => "#{Rails.application.secrets.aws_access_key_id}",
    :aws_secret_access_key  => "#{Rails.application.secrets.aws_secret_access_key}",
    :region                 => 'us-east-1',
    :host                   => 's3-website-us-east-1.amazonaws.com',
    :endpoint               => 'http://s3-website-us-east-1.amazonaws.com'
    }
    config.fog_directory  = 'myfilesflash'
    config.fog_public     = false
  end
end
