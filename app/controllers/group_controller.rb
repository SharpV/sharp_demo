class GroupController < ApplicationController
  before_filter :authenticate_user!, :set_current_group_context  
  layout "group"
  
  set_tab :group, :site_nav 
  
  def set_current_group_context
    @group = Group.find(params[:group_id])
    @group_member = @group.member(current_user)
  rescue    
    @group = nil
    @group_member = nil
  end
 
end
