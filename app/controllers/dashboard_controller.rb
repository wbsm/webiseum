class DashboardController < ApplicationController
	def index
		@number_of_questions = Question.count
		@number_of_forecasts = Forecast.count
		@number_of_users = User.count
		@number_of_tags = Tag.count
	end

end