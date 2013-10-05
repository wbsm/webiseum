module AuthenticationsHelper

  def self.build_webiseum_auth(user)
    auth_hash = Hash.new
    auth_hash['provider'], auth_hash['uid'] = 'identity', -11
    auth_hash['info'] = user.attributes
    auth_hash
  end

  # refactor passar dependencia decontroller para fora
  def self.build_user(auth_hash)
    params = ActionController::Parameters.new(auth_hash['info']).permit(:name, :email, :first_name, :last_name, :image_type, :password, :password_confirmation)

    if auth_hash['provider'] == 'facebook'
      params['gender'], params['birthday'] = auth_hash['extra']['raw_info']['gender'], auth_hash['extra']['raw_info']['birthday']
      params['avatar'] = URI.parse(auth_hash['info']['image'])
    end

    params['password'] = '111111111111111' # nome@timestamp
    params['password_confirmation'] = '111111111111111'

    user = User.create(params)
    user
  end

end
