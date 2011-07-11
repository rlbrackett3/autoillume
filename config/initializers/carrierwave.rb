CarrierWave.configure do |config|
  # In production, use S3
  # In development, use filesystem and processing
  # In testing, use filesystem and no processing

  # To use S3 CNAME, set bucket name to the CNAME:
  #   photos.example.com
  # Set s3_cnamed to true.
  # Set CNAME on your DNS:
  #   cdn.example.com => cdn.example.com.s3.amazonaws.com

  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
       :provider               => 'AWS',            # required
       :aws_access_key_id      => ENV['S3_KEY'],    # required
       :aws_secret_access_key  => ENV['S3_SECRET']  # required
     }
    config.fog_directory  = ENV['S3_BUCKET']        # required
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}

  elsif Rails.env.development?
    config.storage = :file
    # config.store_dir = "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.project.title}_#{model.id}"
  else
    config.storage = :file
    config.enable_processing = false
    #config.store_dir = "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end