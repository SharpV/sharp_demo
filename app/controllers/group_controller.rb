class GroupController < ApplicationController
  before_filter :authenticate_user!, :set_current_context  
  layout "group"
  
  set_tab :group, :site_nav 
  
  def set_current_context
    @current_group = Group.find(params[:group_id])
    @current_group_member = current_user.member(@current_group)
  rescue    
    @current_group = nil
    @current_group_member = nil
  end
 
end
