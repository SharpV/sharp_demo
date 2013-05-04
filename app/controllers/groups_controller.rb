class GroupsController < ApplicationController
  respond_to :html, :js
  set_tab :index, :group_nav, only: [:show]
  set_tab :groups, :site_nav
  def index
    @groups = Group.page(params[:page])
    @hot_groups = Group.hot_groups
    @hot_topics = Group.hot_topics
    @hot_media = Group.hot_media
  end

  def show
    @current_group = Group.find params[:id]
    @apply_members = @current_group.members.apply
    if current_user
      @current_group_member = current_user.member(@current_group)
    else
      @current_group__member = nil
    end
    if @current_group.is_class
      set_tab "webclasses", :site_nav
      @current_group_teachers = @current_group.members.teacher 
    else
      set_tab "groups", :site_nav
    end
    @new_members = @current_group.members.order('created_at desc')
    #@sections = @current_group.current_term.sections.order(:start_at)

    render layout: 'group'
  end
end
