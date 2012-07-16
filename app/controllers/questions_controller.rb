#encoding: utf-8
class QuestionsController < ApplicationController
  set_tab :question, :site_menus
  #load_and_authorize_resource
  #before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.new
  end

  def index
    @questions = Question.all#.page(params[:page])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
      flash[:notice] = "Your Question was successfully created!"
      redirect_to @question
    else
      flash[:error] = "您的问题无法提交!"
      render 'new'
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Your Question was successfully updated!"
      redirect_to @question
    else
      render 'edit'
    end
  end

  protected
    def nav_order
      params[:nav] = "id" unless %w(id vote_points answers_count not_answered).include?(params[:nav])
      params[:order] = "desc" unless %w(desc asc).include?(params[:order])
      "questions.#{params[:nav] == "not_answered" ? "id" : params[:nav]} #{params[:order]}"
    end
end
