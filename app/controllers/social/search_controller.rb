class Social::SearchController < Social::SocialController

  def search
    @users = User.by_name(params['by'])
    render 'social/feed/search'
  end

  def show
    @forecasts = Forecast.by_user_id(params[:id]).order_by_time
    render 'social/feed/forecasts'
  end

end