class GroupsController < GroupController
  set_tab :index, :group_nav

  def index
    @user = current_user 
    @post = Post.new
    @activities = Activity.all
  end
  
  def show
    @current_group = Group.find params[:id]
    self.try "set_tab", "group_#{@current_group.id}", :group_nav
  end
  
  def new
    self.try "set_tab", "new", :group_nav
    
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
      success.html do
        self.current_subject = current_user
        redirect_to :home
      end
    end
  end

end
