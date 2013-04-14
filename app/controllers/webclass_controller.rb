
class WebclassController < ApplicationController
  
  
  before_filter :authenticate_user!, :set_current_context  
  layout "webclass"

  set_tab "webclass", :site_nav
  
  def set_current_context
    @current_webclass = Webclass.find(params[:webclass_id])
    @current_term = @current_webclass.current_term
    @current_webclass_member = current_user.member(@current_webclass)
    @current_webclass_teachers = @current_webclass.members.teacher
  rescue    
    @current_webclass = nil
    @current_webclass_member = nil
  end
  
end