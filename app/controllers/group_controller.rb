
class GroupController < ApplicationController
  
  
  before_filter :authenticate_user!, :set_current_context  
  layout "group"

  
  def set_current_context
    @current_group = Group.find(params[:group_id])
    @current_term = @current_group.current_term if @current_group.is_class
    @current_group_member = current_user.member(@current_group)
    if @current_group.is_class
      set_tab "webclasses", :site_nav
      @current_group_teachers = @current_group.members.teacher 
    else
      set_tab "groups", :site_nav
    end
    @current_namespace = [:group, @current_group]
    current_user.read(@current_group)
  rescue    
    @current_group = nil
    @current_group_member = nil
    redirect_to root_path
  end

end