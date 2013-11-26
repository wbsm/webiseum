Webiseum::Application.configure do

  # Facebook auth params
  # App name: Webiseum Stage Env
  # Namespace: webiseum-stage
  ENV['FACEBOOK_KEY']     = '183628885133285'
  ENV['FACEBOOK_SECRET']  = '96f7cfdfbc351edd0ad948014c504920'

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

  config.assets.js_compressor = :uglifier

  config.assets.digest = true

  config.assets.version = '1.1'

  # Set to :debug to see everything in the log.
  config.log_level = :info

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  config.paperclip_defaults = {
      :storage => :s3,
      :s3_protocol => 'http',
      :s3_credentials => {
          :bucket =>  'wbsm',
          :access_key_id => 'AKIAJSDRCG75H3NVMN4A',
          :secret_access_key => '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'
      }
  }
end
