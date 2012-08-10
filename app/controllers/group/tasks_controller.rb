class Group::TasksController < GroupController

  before_filter :set_group_tab
  set_tab :task, :group_menus
  set_tab :task, :group_actions, :only => %w(new edit)

  def index
    @tasks = Task.all
  end
  
  
  def show
    @task = Group::Task.find(params[:id])
  end


  def new
    @task = Group::Task.new
 end


  def create
    @task = current_user.tasks.build params[:group_task]
    if @task.save
      puts @task.id
      redirect_to group_task_path(@current_group, @task)
    else
      render :action => :new
    end
  end


  def update
    @task = Group::Task.find(params[:id])
    if @task.update_attributes(params[:forum_topic])
      redirect_to group_task_path(@current_group, @task)
    else
      render :action => :new
    end
  end


  def destroy
    @forum_topic = ForumTopic.find(params[:id])
    @forum_topic.destroy
    respond_to do |format|
      format.html { redirect_to(forum_topics_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
