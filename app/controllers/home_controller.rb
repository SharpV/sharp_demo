class HomeController < ApplicationController
  #before_filter :authenticate_user!

  set_tab :index, :site_nav
  #layout 'group'
  set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    unless current_user 
      redirect_to(sign_in_path) 
    end
  end
end
