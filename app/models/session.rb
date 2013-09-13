class Session

	def self.is_valid_user(user_id)
		User.where(:id => user_id).count > 0 ? true : false
	end

end
