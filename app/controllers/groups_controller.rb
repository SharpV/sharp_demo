class GroupsController < ApplicationController
  set_tab :index, :group_nav  
  set_tab :group, :site_nav

  def index
    @user = current_user 
    @post = Post.new
  end
  
  def show
    @current_group = Group.find params[:id]
    current_group_member = current_user.member(@current_group)
    render layout: 'group'
  end

  def create
    @group = Group.new(params[:group])
    @group.user = current_user
    if @group.save
      redirect_to @group  
    else
      render :action => :new
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        self.current_subject = current_user
        redirect_to :home
      end
    end
  end

end
