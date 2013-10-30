class Social::QuestionForecastController < Social::SocialController

  # match forecast user -> question
  def new
    user_id = session['user_id']
    question_id = params['question_id']

    puts "################# [Webiseum][ForecastsController:match] user_id #{user_id}"
    puts "################# [Webiseum][ForecastsController:match] question_id #{question_id}"

    forecast = Forecast.find_or_initialize_by(:user_id => user_id, :question_id => question_id)
    puts "################# [Webiseum][ForecastsController:match] forecast #{forecast}"
    unless forecast
      puts "################# [Webiseum][ForecastsController:match] in unless forecast"
      forecast = Forecast.new

      forecast.question = Question.find(question_id)
      forecast.logged_user = @logged_user
    end

    forecast.answer = params['answer'+question_id]
    forecast.rating = params['rating'+question_id]
    forecast.comment = params['comment'+question_id]
    puts "################# [Webiseum][ForecastsController:match] params #{params}"
    if !forecast.save
      puts "################# [Webiseum][ForecastsController:match] in !forecast.save"
      # criar objeto de resposta para json
      flash[:answer] = Hash.new
      flash[:answer][:has_errors] = true
      flash[:answer][:message] = "Campos obrigatórios: #{forecast.errors.full_messages.join(', ')}"
    else
      puts "################# [Webiseum][ForecastsController:match] in else !forecast.save"
      flash[:answer] = Hash.new
      flash[:answer][:has_errors] = false
      flash[:answer][:message] = "Você previu #{forecast.answer}"
    end

    puts "################# [Webiseum][ForecastsController:match] flash #{flash[:answer]}"

    respond_to do |format|
      format.js
    end
  end

  # rematch forecast user -> question
  def update
    respond_to do |format|
      format.js
    end
  end

  private

end
