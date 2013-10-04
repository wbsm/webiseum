class Social::FeedController < Social::SocialController
	layout "social"

  def index
  		@questions = Question.find_not_expired
		@tags = Tag.all
  end

  def user_forecast
    @forecasts = Forecast.where(:user_id => session['user_id'])
  end

  def all_forecasts
    @forecasts = Forecast.all
  end

  def filter_by_tags
    @questions = Question.joins(:tags).where('tags.name' => params[:id])

    render "index"
  end

end