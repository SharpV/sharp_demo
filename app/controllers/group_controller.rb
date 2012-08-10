class GroupController < ApplicationController
  before_filter :authenticate_user!, :set_current_group  
  layout "group"
  
  def set_current_group
    @current_group = Group.find(params[:group_id])
  rescue    
    @current_group = nil
  end
  
  def set_group_tab
    self.try "set_tab", "group_#{@current_group.id}", :group_nav
    self.set_tab :index, :site_nav
  end
 
end
