class UsersController < ApplicationController

  set_tab :index, :user_nav
  set_tab :index, :site_nav


  respond_to :html, :js
  
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
    @current_user = User.find params[:id]
    @webclasses = @current_user.groups.webclass
    @groups = @current_user.groups.webgroup

    if current_user.followings_count < 10
      @recommand_users = User.includes(:follows).where("id not in (?)", current_user.followings.map(&:actor_id)).limit(18)
    else
      @recommand_users = User.includes(:follows).limit(5)
    end
    render layout: 'user'
  end

  def new
    @user = User.new
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow!(@user)
    @new_user = User.where("id not in (?)", current_user.followings.map(&:actor_id)).first
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
  end

end
