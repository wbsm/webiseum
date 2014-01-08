class Social::FeedController < Social::SocialController
	before_action :store_action, only: [:question, :forecast]
  before_action :populate_rank, except: [:tag]

  def index
    @questions = Question.not_expired
  end

  def question
    if params['id'].to_i != 0 && params['id'].to_i.is_a?(Numeric)
      @questions = Question.not_expired.not_ranked
      render 'social/feed/index'
    else
      @questions = Question.not_expired.not_ranked
      render 'social/feed/index'
    end
  end

  def forecast
    if params['id'].to_i != 0 && params['id'].to_i.is_a?(Numeric)
      @forecasts = Forecast.by_user_id(params['id']).order_by_time
      #render 'social/feed/user_forecasts'
    else
      @forecasts = Forecast.order_by_time
      #render 'social/feed/forecasts'
    end
    render 'social/feed/forecasts'
  end

  def tag
    if current_action == 'forecast'
      @forecasts = Forecast.by_tag(params[:id]).order_by_time
      @rank = TagRank.by_tag(params[:id])
      render 'social/feed/forecasts' and return
    elsif current_action == 'forecast_with_id'
      @forecasts = Forecast.by_user_id(session['user_id']).by_tag(params[:id]).order_by_time
      @rank = TagRank.by_tag(params[:id])
      render 'social/feed/forecasts' and return
    else
        @questions = Question.by_tag(params[:id]).not_expired.not_ranked
        @rank = TagRank.by_tag(params[:id])
        render 'social/feed/index' and return
    end

    redirect_to :action => :index
  end

  private
    def current_action
      session['webiseum']['action'] if !session['webiseum'].nil?
    end

    def store_action
      session['webiseum'] = Hash.new
      if params['id'].to_i != 0 && params['id'].to_i.is_a?(Numeric)
        session['webiseum']['action'] = "#{params['action'].to_s}_with_id"
      else
        session['webiseum']['action'] = params['action'].to_s
      end
    end

end