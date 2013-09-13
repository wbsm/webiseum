class Authentication < ActiveRecord::Base

	belongs_to :user

	validates :provider, :uid, :presence => true

	def self.find_or_create(auth_hash)
	  auth = self.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	  
	  unless auth
	    user = User.create :full_name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
	    auth = Authentication.create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	  end
	 
	  auth
	end

end
