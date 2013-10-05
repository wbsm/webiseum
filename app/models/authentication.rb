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
      user = AuthenticationsHelper.build_user(auth_hash)
      user.save
    end

    create_social_auth(user, auth_hash)
	end

  def self.create_social_auth(user, auth_hash)
    create_auth(user, auth_hash)
  end

  def self.create_webiseum_auth(user)
    auth_hash = AuthenticationsHelper.build_webiseum_auth(user)
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

  # associations
  belongs_to :user
end
