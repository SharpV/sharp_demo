class AnswersController < ApplicationController
  def my
    @answers = current_user.answers.includes(:question).order('created_at desc').page params[:page]
    set_tab :answers, :questions_nav
  end
  
  def create
    @question = Question.find params[:question_id]
    @answer = current_user.answers.build params[:answer]
    @answer.question = @question
    if @answer.save
      redirect_to question_path(@question)+"#answer-#{@answer.id}"
    else
      render :template => 'questions/show'
    end 
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url
  end
end