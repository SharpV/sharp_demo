class HomeController < ApplicationController
  set_tab :index, :site_nav
  layout 'group'
  #set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    redirect_to(new_user_session_path) unless current_user 
  end
end
