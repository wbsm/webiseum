Webiseum::Application.configure do

  # Facebook auth params
  # App name: Webiseum Stage Env
  # Namespace: webiseum-stage
  ENV['FACEBOOK_KEY']     = '1375648122671695'
  ENV['FACEBOOK_SECRET']  = '6ce81bc54045df0530330400f7c48bf5'

  # Twitter auth params
  # App name: wbsm-stage-env
  # Description: wbsm-stage
  ENV['CONSUMER_KEY']     = 'dwOcfIQZFEBcRR2PJrA'
  ENV['CONSUMER_SECRET']  = 'fkPX3kchlKazHZpDPRXhwNBxIkoPWVHCGggPQlnjAWw'

  # Google+ auth params
  # App name: wbsm-development-env
  # Description: wbsm-development
  ENV['GOOGLE_KEY']       = '520650340316.apps.googleusercontent.com'
  ENV['GOOGLE_SECRET']    = 'jgkf5IXWJPJKbmTmrusKVWoc'

  # Paperclip avatar manager
  Paperclip.options[:command_path] = '/usr/local/bin/'

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

  config.assets.compile = false
  config.assets.digest = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
end
