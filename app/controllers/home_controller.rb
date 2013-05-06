class HomeController < ApplicationController

  set_tab :index, :site_nav
  #layout 'group'
  set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    if current_user 
      redirect_to [:me, :users]
    else
      redirect_to new_session_path(resource_name)
    end
  end
end
