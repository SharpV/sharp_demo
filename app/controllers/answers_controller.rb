class AnswersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def create
    @question = Question.find params[:question_id]
    @answer = current_user.answers.build(params[:answer].merge(:question_id => @question.id))
    if @answer.save
      redirect_to @question, :notice => "Your Answer was successfully created!"
    else
      render 'questions/show'
    end
  end

  def update
    @answer = current_user.answers.find_cached(params[:id])
    if @answer.update_attributes(params[:answer])
      redirect_to @question, :notice => "Your Answer was successfully updated!"
    else
      render 'questions/show'
    end
  end

end
