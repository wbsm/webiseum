class WebiseumController < ApplicationController
	skip_before_filter :verify_logged_user

	def index
	  redirect_to social_feed_path if Session.is_logged_user(@logged_user)
  end

  def unregistered

  end

end