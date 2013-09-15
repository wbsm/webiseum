class LandingPageController < ApplicationController
	skip_before_filter :verify_logged_user, :only => [:index, :new_user]
	
	def index
		
  end

  def new_user

  end

end