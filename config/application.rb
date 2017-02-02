require_relative 'boot'

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SnifferBackend
  class Application < Rails::Application

    # Default locales
    config.i18n.default_locale = :'pt-BR'

    

    # AWS settings
    config.paperclip_defaults = {
      storage: :s3,
      s3_protocol: :https,
      s3_region: ENV['AWS_REGION'],
      s3_host_name: ENV['S3_HOST_NAME'],
      s3_credentials: {
        bucket: ENV['AWS_BUCKET'],
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }
    }

  end
end
