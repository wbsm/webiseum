class Social::ForecastsController < Social::SocialController
  layout "social"

  # match forecast user -> question
  def match
    user_id = session['user_id']
    question_id = params['question_id']

    forecast = Forecast.find_or_initialize_by(:user_id => user_id, :question_id => question_id)
    unless forecast
      forecast = Forecast.new

      forecast.question = Question.find(question_id)
      forecast.logged_user = @logged_user
    end

    forecast.answer = params['answer'+question_id]
    forecast.rating = params['rating'+question_id]
    forecast.comment = params['comment'+question_id]

    forecast.save

    flash[:answer] = forecast.answer

    respond_to do |format|
      format.js
    end
  end

  # rematch forecast user -> question
  def rematch
    respond_to do |format|
      format.js
    end
  end

  private

end
