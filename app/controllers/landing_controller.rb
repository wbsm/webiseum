class LandingController < ApplicationController
	skip_before_filter :verify_logged_user, :only => [:index]
	
	def index
		
	end

end