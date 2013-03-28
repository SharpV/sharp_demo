class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js

  set_tab :questions, :site_nav


  def index
   
  end

  def new
    @question = Question.new
  end
end
