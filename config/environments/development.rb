Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=172800"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.delivery_method :smtp
  host = "localhost"
  config.action_mailer.default_url_options = {host: host, port: 3000}
  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: "587",
    authentication: :plain,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    domain: "gmail.com",
    enable_starttls_auto: true
  }
  config.action_mailer.perform_deliveries = true

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.middleware.use SimplesIdeias::I18n::Middleware

  config.assets.initialize_on_precompile = true

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
