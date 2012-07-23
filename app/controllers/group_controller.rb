class GroupController < ApplicationController
  before_filter :set_current_group
  layout 'group'
  
  
  def set_current_group
    @current_group = Group.find(params[:group_id])
  rescue    
    @current_group = nil
  end
  

end
