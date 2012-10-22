
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJ75FNXLXWFDOP75Q',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = 'bryanmytko_bme'
  config.storage = :fog
  config.cache_dir = '#{Rails.root}/tmp/uploads'
  config.root = Rails.root.join('tmp')
end