class UsersController < ApplicationController
  
  def search
    if params[:q].present?
      @users = User.search(params[:q])
    else
      @users = User.paginate :page => params[:page], :per_page => 10
    end
    respond_to do |format|
      format.js {}
      format.html { render :index }
    end
  end

  def show
    @my_webclasses = current_user.webclasses
    @my_groups = current_user.groups
    render layout: 'user'
  end

  def new
    @user = User.new
  end

  def reputation
    @user = User.find(params[:id])
  end

end
