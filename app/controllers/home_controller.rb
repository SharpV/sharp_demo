class HomeController < ApplicationController
  #set_tab :home, :user_menus
  #set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    redirect_to new_session_path(resource_name) unless current_user
    @user = current_user 
    @user.count_view! unless current_user == @user
    @activity = Activity.new
  end
  
  def posts
    unless params[:type]
      redirect_to home_path
    else
      if Post::TYPES.keys.include? params[:type]
        @posts = current_user.posts.by_type(Post::TYPES[params[:type]]).order(:created_at).page params[:page]
      else
        @posts = current_user.posts.order(:created_at).page params[:page]
      end
    end
  end
end
