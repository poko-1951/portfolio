require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.after_initialize do
    Bullet.enable        = false
    Bullet.alert         = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  #deviseが認証用のURLなどを生成するのに必要になる（らしい）
  config.action_mailer.default_url_options = { protocol: 'https', host:'https://34b81943009147c2b51f4e648fc83bc4.vfs.cloud9.ap-northeast-1.amazonaws.com'}
  #送信方法を指定（この他に:sendmail/:file/:testなどがあります)
  config.action_mailer.delivery_method = :smtp
  #送信方法として:smtpを指定した場合は、このconfigを使って送信詳細の設定を行います
  config.action_mailer.smtp_settings = {
    #gmail利用時はaddress,domain,portは下記で固定
    address:"smtp.gmail.com",
    domain: 'gmail.com',
    port:587,
    #gmailのユーザアカウント（xxxx@gmail.com)
    user_name: ENV['MAIL_USER_NAME'],
    #gmail２段階認証回避のためにアプリケーションでの利用パスワードを取得
    password: ENV['MAIL_PASSWORD'],
    #パスワードをBase64でエンコード
    authentication: :login
  }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
  config.hosts << "34b81943009147c2b51f4e648fc83bc4.vfs.cloud9.ap-northeast-1.amazonaws.com"
end
