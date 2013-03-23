class GroupController < ApplicationController
  before_filter :authenticate_user!, :set_current_group_context  
  layout "group"
  
  def set_current_group_context
    @group = Group.find(params[:group_id])
    @group_member = @group.member(current_user)
  rescue    
    @group = nil
    @group_member = nil
  end
  
  def set_group_tab
    self.try "set_tab", "group_#{@current_group.id}", :group_nav
    self.set_tab :index, :site_nav
  end
 
end
