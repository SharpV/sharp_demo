class MyController < ApplicationController
  set_tab :home, :site_menus
  def find_user
    unless params[:user_id] and (@user = User.find_by_login params[:user_id])
      @user = current_user 
    end
  end
end
