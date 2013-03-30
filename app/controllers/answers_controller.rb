class AnswersController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
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