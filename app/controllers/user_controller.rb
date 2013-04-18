class UserController < ApplicationController
  before_filter :authenticate_user!, :set_current_context  
  set_tab :index, :site_nav
  
  layout "user"

  def set_current_context
    if params[:user_id]
      @current_user = User.where(login: params[:user_id]).first || nil
    else
      @@current_user = nil
    end
  end
  
end
