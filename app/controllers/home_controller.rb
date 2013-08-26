class HomeController < ApplicationController
	layout "webiseum"

	def index
		@forecasts = Forecast.all	
	end

end