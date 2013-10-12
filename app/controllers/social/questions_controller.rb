class Social::QuestionsController < Social::SocialController
  before_action :set_question, only: [:show]

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

end
