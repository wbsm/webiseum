=begin
create_table "authentications", force: true do |t|
  t.integer  "user_id"
  t.string   "provider"
  t.string   "uid"
  t.datetime "created_at"
  t.datetime "updated_at"
end
=end
class Authentication < ActiveRecord::Base

  validates_presence_of :provider, :uid

  # utilizado para criacao de login de rede sociais e webiseum
  # fluxo: twitter, facebook, google+ o parametro auth_hash nao e nil
  # fluxo: webiseum o parametro auth_hash e nil e e criado o hash
	def self.find_or_create(user, auth_hash)
    user = User.includes(:authentications).find_by_email(auth_hash['info']['email']) if !user.present?
    if !user.present?
      user = User.create(build_info_params(auth_hash['info']))
    end

    create_social_auth(user, auth_hash)
	end

  def self.create_social_auth(user, auth_hash)
    create_auth(user, auth_hash)
  end

  def self.create_webiseum_auth(user)
    auth_hash = build_webiseum_auth(user)
    create_auth(user, auth_hash)
  end

  private
    def self.create_auth(user, auth_hash)
      provider_name, provider_uid = auth_hash['provider'], auth_hash['uid']
      user.authentications.each do |auth|
        return auth if auth.provider == provider_name
      end

      Authentication.create(:user => user, :provider => provider_name, :uid => provider_uid)
    end

    def self.build_webiseum_auth(user)
      auth_hash = Hash.new
      auth_hash['provider'], auth_hash['uid'] = 'identity', -11
      auth_hash['info'] = user.attributes
      auth_hash
    end

    # refactor passar dependencia decontroller para fora
    def self.build_info_params(auth_hash)
      params = ActionController::Parameters.new(auth_hash).permit(:name, :email, :first_name, :last_name, :image, :password, :password_confirmation)
      params['password'] = '111111111111111' # nome@timestamp
      params['password_confirmation'] = '111111111111111'
      params
    end

  # associations
  belongs_to :user
end
