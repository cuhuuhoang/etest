class FileUploader < CarrierWave::Uploader::Base
    # encoding: utf-8

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    # include CarrierWave::MiniMagick

  storage :file
  # storage :fog
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  if model.type == 'Picture'
    include CarrierWave::MiniMagick
    process resize_to_limit: [400, 400]
    # Choose what kind of storage to use for this uploader:

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{model.type.underscore}/#{mounted_as}/#{model.id}"
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    version :thumbnail do
      process resize_to_fill: [50, 50, 'Center']
    end
  end

  if model.type == 'Sound'

  end
end