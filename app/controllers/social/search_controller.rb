class Social::SearchController < Social::SocialController
  layout "social"

  def search
    @forecasts = Forecast.by_user_name(params['by']).order_by_time
    render 'social/feed/forecasts'
  end

end