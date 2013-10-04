Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, fields: [:first_name, :last_name, :email, :birthdate, :gender], model: User, :on_failed_registration => SessionsController.action(:new)
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end