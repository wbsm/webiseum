class WebiseumController < ApplicationController
  layout 'webiseum'

  before_action :redirect_to_feed

  def index
	  redirect_to feed_path if Session.is_logged_user(@logged_user)
  end

  def unregistered

  end

  private
    def redirect_to_feed

      if !User.find_by_id(session[:user_id]).nil?
        redirect_to feed_path
      end

    end

end