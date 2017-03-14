require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join("lib", "locale", "*.{rb,yml}")]
    config.i18n.default_locale = :en
  end
end
