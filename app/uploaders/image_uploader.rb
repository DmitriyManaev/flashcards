class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  process resize_to_limit: [360, 360]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
