class HomeController < ApplicationController
  set_tab :index, :group_nav
  #set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    redirect_to groups_path
  end
end
