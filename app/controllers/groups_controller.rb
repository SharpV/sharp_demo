class GroupsController < ApplicationController
  set_tab :index, :group_nav  
  set_tab :group, :site_nav

  def index
    @user = current_user 
    @post = Post.new
  end
  
  def show
    @group = Group.find params[:id]
    if current_user
      @group_member = @group.member(current_user)
    else
      @group_member = nil
    end
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
