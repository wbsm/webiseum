class Social::QuestionForecastController < Social::SocialController

  # match forecast user -> question
  def create
    question_id = params[:question_id]

    forecast_web = {
        user_id: session['user_id'],
        question_id: question_id,
        answer: params['answer'+question_id],
        rating: params['rating'+question_id],
        comment: params['comment'+question_id]
    }

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
