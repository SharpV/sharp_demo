class HomeController < ApplicationController

  set_tab :index, :site_nav
  #layout 'group'
  set_tab :home, :site_menus
  #set_tab :timeline, :user_timeline_menus
  
  def index
    @products = Product.display.includes(:category).order('created_at desc').page params[:page]
  end

end
