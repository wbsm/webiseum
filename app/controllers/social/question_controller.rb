class Social::QuestionController < Social::SocialController
  before_action :set_question, only: [:show, :create]

  def show

  end

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

    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      id = params[:id] != nil ? params[:id] : params[:question_id]
      @question = Question.find(id)
    end

end
