class GradesController < ApplicationController
  respond_to :js, :html
  helper UsersHelper
  before_filter :authenticate_user!, :only => [:toggle]

  def index
    @user = User.find params[:user_id]
    @questions = @user.favourite_questions.paginate :page => params[:page], :per_page => 25
    render "/users/favourites", :layout => true
  end

  def show
    @grade = Grade.find params[:id]
  end

end