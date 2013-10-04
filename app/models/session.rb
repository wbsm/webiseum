class Session

  def self.is_logged_user(logged_user)
    find_user(logged_user.id) if !logged_user.nil?
  end

end
