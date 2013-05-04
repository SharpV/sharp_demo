class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js

  set_tab :questions, :site_nav


  def index
   if params[:grade_id]
      @questions = Question.share.includes(:user).where(grade_id: params[:grade_id]).page params[:page]
    elsif params[:subject_id]
      @questions = Question.share.includes(:user).where(subject_id: params[:subject_id]).page params[:page]
    else
      @questions = Question.share.includes(:user).page params[:page]
    end
    @top_users = Question.top_users
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
