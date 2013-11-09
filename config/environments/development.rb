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

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
end
