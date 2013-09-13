class DashboardController < ApplicationController
	layout "admin"

	def index
		@user = User.find(session["user_id"])
		@number_of_questions = Question.count
		@number_of_forecasts = Forecast.count
		@number_of_users = User.count
		@number_of_tags = Tag.count
	end

end