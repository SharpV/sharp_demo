class GroupController < ApplicationController
  before_filter :set_current_group
  layout "group"
  
  def set_current_group
    @current_group = Group.find(params[:group_id])
    self.try "set_tab", "group_#{@current_group.id}", :group_nav
  rescue    
    @current_group = nil
  end
  

end
