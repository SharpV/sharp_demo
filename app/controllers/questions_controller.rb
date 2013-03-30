class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js

  set_tab :question, :site_nav


  def index
   @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build params[:question]
    if @question.save
      redirect_to @question
    else
      render action: :new
    end
  end

  def show
    @question = Question.find params[:id]
    @answer = Answer.new question: @question
  end

  def update
    @question = Question.find params [:id]
    if @question.update_attributes params[:question]
      redirect_to @question
    else
      render action: :edit
    end
  end

  def destroy
    @question = Question.find params [:id]
    @question.destroy
    redirect_to params[:return] || me_questions_path
  end
end
