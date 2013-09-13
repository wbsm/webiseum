class User < ActiveRecord::Base

	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	validates_presence_of :full_name, :email
	validates_length_of :full_name, allow_blank: false
	validates_uniqueness_of :email
	validates_format_of :email, with: EMAIL_REGEXP
	
	#has_secure_password

	has_many :authentications
	has_many :forecasts
  	has_many :questions, through: :forecasts

  	# add new provider if not exist
	def add_provider(auth_hash)
		unless authentications.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
			Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
		end
	end

end
	