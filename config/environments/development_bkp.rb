Webiseum::Application.configure do

  # Facebook auth params
  # App name: wbsm-development-env
  # Namespace: wbsm-development
  ENV['FACEBOOK_KEY']     = '164133423784670'
  ENV['FACEBOOK_SECRET']  = 'e9bbee6d33f527d469d3125e5b7c60a4'

  # Twitter auth params
  # App name: wbsm-development-env
  # Description: wbsm-development
  ENV['CONSUMER_KEY']     = 'dwOcfIQZFEBcRR2PJrA'
  ENV['CONSUMER_SECRET']  = 'fkPX3kchlKazHZpDPRXhwNBxIkoPWVHCGggPQlnjAWw'

  # Google+ auth params
  # App name: wbsm-development-env
  # Description: wbsm-development
  ENV['GOOGLE_KEY']       = '520650340316.apps.googleusercontent.com'
  ENV['GOOGLE_SECRET']    = 'jgkf5IXWJPJKbmTmrusKVWoc'

  # Paperclip avatar manager
  #Paperclip.options[:command_path] = '/usr/local/bin/'
  Paperclip.options[:command_path] = '/usr/bin/'

  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
