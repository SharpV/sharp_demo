class UserController < ApplicationController
  before_filter :authenticate_user!, :set_current_context  
  set_tab :index, :site_nav
  
  layout "user"

  def set_current_context
    if params[:user_id]
      @current_user = User.find params[:user_id]
    else
      @current_user = nil
      redirect_to root_path
    end
  end
  
end
