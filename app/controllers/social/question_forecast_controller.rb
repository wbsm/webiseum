class Social::QuestionForecastController < Social::SocialController

  # match forecast user -> question
  def create
    question_id = params[:question_id]

    forecast_web = Hash.new
    forecast_web['user_id'] = session['user_id']
    forecast_web['question_id'] = question_id
    forecast_web['answer'] = params['answer'+question_id]
    forecast_web['rating'] = params['rating'+question_id]
    forecast_web['comment'] = params['comment'+question_id]

    flash[:answer] = Forecast.match(forecast_web)

    respond_to do |format|
      format.js
    end
  end

  # rematch forecast user -> question
  def update
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

end
