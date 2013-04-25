class GroupsController < ApplicationController
  respond_to :html, :js
  set_tab :index, :webclass_nav, only: [:show]
  def index
  end

  def show
    @current_group = Group.find params[:id]
    @apply_members = @current_group.members.apply
    if current_user
      @current_group_member = current_user.member(@current_group)
    else
      @current_group__member = nil
    end
    #@sections = @current_group.current_term.sections.order(:start_at)

    render layout: 'group'
  end
end
