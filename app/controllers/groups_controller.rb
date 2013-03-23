class GroupsController < ApplicationController
  set_tab :admin, :group_nav  
  def index
    @user = current_user 
    @post = Post.new
  end
  
  def show
    redirect_to group_group_topics_path params[:id]
  end

  
  def admin
    @group = Group.find params[:id]
    @group_member = @group.member current_user
    render :layout => 'group'
  end
  
  def update
    @current_group = Group.find params[:id]
    if @current_group.update_attributes params[:group]
      redirect_to @current_group  
    else  
      render :controller => "group/settings", :action => :index
    end
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
