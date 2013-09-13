class FeedController < ApplicationController
	layout "webiseum"

	def index
		@user = User.find(session['user_id'])	
		@questions = Question.order("finish_at DESC")
		@tags = Tag.all
	end

end