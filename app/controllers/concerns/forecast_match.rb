module ForecastMatch
  extend ActiveSupport::Concern

  module ClassMethods

    def match(forecast_web)

      forecast_db = Forecast.find_or_initialize_by(:user_id => forecast_web[:user_id], :question_id => forecast_web[:question_id])
      unless forecast_db
        forecast_db = Forecast.new
        forecast_db.question_id = forecast_web.question_id
      end

      forecast_db.answer, forecast_db.rating, forecast_db.comment = forecast_web[:answer], forecast_web[:rating], forecast_web[:comment]

      answer = Hash.new
      if !forecast_db.save
        answer[:has_errors] = true
        answer[:message] = "Campos obrigatórios: #{forecast_db.errors.full_messages.join(', ')}"
      else
        answer[:has_errors] = false
        answer[:message] = "Você previu #{forecast_db.answer}"
      end

      answer
    end

  end

end