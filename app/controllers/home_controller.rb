class HomeController < ApplicationController

	def index
		@forecasts = Forecast.all	
	end

end