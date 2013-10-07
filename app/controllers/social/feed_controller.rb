class Social::FeedController < Social::SocialController
	layout "social"

  before_action :store_action, only: [:question, :forecast]

  def index
  	@questions = Question.not_expired
  end

  def question
    if params['id'].to_i != 0 && params['id'].to_i.is_a?(Numeric)
      @questions = Question.not_expired
      render 'social/feed/index'
    else
      @questions = Question.not_expired
      render 'social/feed/index'
    end
  end

  def forecast
    if params['id'].to_i != 0 && params['id'].to_i.is_a?(Numeric)
      @forecasts = Forecast.order_by_time.from_user(params['id'])
      render 'social/feed/user_forecasts'
    else
      @forecasts = Forecast.order_by_time
      render 'social/feed/forecasts'
    end
  end

  def tag
    if current_action == 'question'
      @questions = Question.joins(:tags).where('tags.name' => params[:id]).not_expired
      render 'social/feed/index' and return
    elsif current_action == 'forecast'
      @forecasts = Forecast.joins(question: :tags).where('tags.name' => params[:id]).distinct(:question).order_by_time
      render 'social/feed/forecasts' and return
    elsif current_action == 'forecast_user'
      @forecasts = Forecast.joins(question: :tags).where('tags.name' => params[:id], user_id: session['user_id']).distinct(:question).order_by_time
      render 'social/feed/forecasts' and return
    end

    redirect_to :action => :index
  end

  private
    def current_action
      session['webiseum']['action'] if !session['webiseum'].nil?
    end

    def store_action
      if params['id'].to_i != 0 && params['id'].to_i.is_a?(Numeric)
        session['webiseum'], session['webiseum']['action'] = Hash.new, "#{params['action'].to_s}_user"
      else
        session['webiseum']['action'] = params['action'].to_s
      end
    end

end