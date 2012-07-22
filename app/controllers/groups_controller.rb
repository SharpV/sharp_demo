class GroupsController < ApplicationController
  set_tab :new, :group_nav

  def index

  end
  
  def show
    @group = Group.find params[:id]
    self.try "set_tab", "group_#{@group.id}", :group_nav
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(params[:group])
    if @group.save
      redirect_to @group  
    else
      render :action => :new
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html {
        self.current_subject = current_user
        redirect_to :home
      }
    end
  end

  protected

  # Overwrite resource method to support slug
  # See InheritedResources::BaseHelpers#resource
  def resource
    @group ||= end_of_association_chain.find_by_slug!(params[:id])
  end

  private

  def set_founder
    params[:group]                  ||= {}
    params[:group][:author_id]      ||= current_subject.try(:actor_id)
    params[:group][:user_author_id] ||= current_user.try(:actor_id)
  end
end
