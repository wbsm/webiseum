Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, fields: [:first_name, :last_name, :email], model: User, :on_failed_registration => SessionsController.action(:new)
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :scope => 'email,user_birthday'
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']

  end