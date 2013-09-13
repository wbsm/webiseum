Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '186877114827653', '4bc1cc7f983067449ae15d18788d0a82'
end