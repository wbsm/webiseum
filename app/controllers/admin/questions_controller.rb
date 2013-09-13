class Admin::QuestionsController < Admin::AdminController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def search
    @questions = Question.where("title like ?", '%'+params[:search_field]+'%')
    render "index"
  end

  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @tags = Tag.all
  end

  # GET /questions/1/edit
  def edit
    @tags = Tag.all
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    
    unless params[:tags].nil? 
      @question.tags = Tag.find(params[:tags])
    end
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to admin_question_path(@question), notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        @tags = Tag.all
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.tags = Tag.find(params[:tags])
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to admin_question_path(@question), notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finish/1
  def finish
    
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description, :publish_at, :finish_at, :event_at, :answers, :correct_answer, :image)
    end
end
