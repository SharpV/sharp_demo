class HomeController < ApplicationController
  #before_filter :authenticate_user!

  set_tab :index, :site_nav
  #layout 'group'
  set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    if current_user 
      @user = current_user
    else
      redirect_to(sign_in_path) 
    end
  end
end
