class Session

  def self.is_logged_user(logged_user)
    User.find_by_id(logged_user.id) if !logged_user.nil?
  end

end
