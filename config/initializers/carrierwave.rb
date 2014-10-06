CarrierWave.configure do |config|
  # if Rails.env.production?
    storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['ACCESS_ID'],
      :aws_secret_access_key  => ENV['ACCESS_KEY']
    }
    config.fog_directory  = ENV['BUCKET']
  # else
    # storage = :file
  # end
  config.enable_processing = Rails.env.development? || Rails.env.production?
end
