class My::UsersController < ApplicationController
  set_tab :user, :site_menus
  set_tab :timeline, :user_timeline_menus
  
  def index
    @tags = User.tag_counts_on(:tags)
    @users = User.page(params[:page])
  end
  
  def show
    @user = User.find_by_login(params[:id])
    @user.count_view! unless current_user == @user
  end
end
