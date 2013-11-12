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
  include Migration::UserMigration

  validates_presence_of :provider, :uid

  # utilizado para criacao de login de rede sociais e webiseum
  # fluxo: twitter, facebook, google+ o parametro auth_hash nao e nil
  # fluxo: webiseum o parametro auth_hash e nil e e criado o hash
	def self.find_or_create(auth_hash)
    user_db = find_or_create_user(auth_hash)
    auth = create_auth(user_db, auth_hash)

    # TODO [webiseum migration] : remover quando nao tiver mais suporte a migracao de usuarios.
    Authentication.migrate(auth)

    auth
	end

  def self.create_identity_auth(user)
    auth_hash = AuthenticationsHelper.build_webiseum_auth(user)
    create_auth(user, auth_hash)
  end

  # TODO Migrar para AuthenticationsHelper
  private
    def self.find_or_create_user(auth_hash)
      user_db = User.includes(:authentications).find_by_email(auth_hash['info']['email'])

      if !user_db.present?
        user_db = AuthenticationsHelper.build_user(auth_hash)
      end

      # atualiza usuario com o time_zone do browser
      user_db.time_zone = auth_hash['time_zone'] if auth_hash['time_zone'].present?

      # sempre atualiza
      user_db.save
      user_db
    end

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
