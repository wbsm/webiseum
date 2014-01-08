class Social::QuestionController < Social::SocialController
  before_action :set_question, only: [:show, :create]

  def show

  end

  def create
    question_id = params[:question_id]

    forecast_web = Hash.new
    forecast_web['user_id'] = session['user_id']
    forecast_web['question_id'] = question_id
    forecast_web['answer'] = params['answer'+question_id]
    forecast_web['rating'] = params['rating'+question_id]
    forecast_web['comment'] = params['comment'+question_id]

    flash[:answer] = Forecast.match(forecast_web)

    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      id = params[:id] != nil ? params[:id] : params[:question_id]
      @question = Question.find(id)
    end

end
