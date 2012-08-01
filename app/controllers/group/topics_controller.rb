class Group::TopicsController < GroupController
  
  before_filter :set_group_tab
  set_tab :topic, :group_menus
  set_tab :topic, :group_actions, :only => %w(new edit)
  
  
  def index
    @forum_topics = ForumTopic.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_topics }
      format.json { render :json => @forum_topics.to_json } 
    end
  end
  
  
  def show
    @topic = Group::Topic.find(params[:id])
  end


  def new
    @topic = Group::Topic.new
 end


  def create
    @topic = current_user.topics.build params[:group_topic]
    if @topic.save
      puts @topic.id
      redirect_to group_topic_path(@current_group, @topic)
    else
      render :action => :new
    end
  end


  def update
    @forum_topic = ForumTopic.find(params[:id])
    respond_to do |format|
      if @forum_topic.update_attributes(params[:forum_topic])
        flash[:notice] = 'ForumTopic was successfully updated.'
        format.html { redirect_to(@forum_topic) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_topic.errors, :status => :unprocessable_entity }
        format.json { render :json => @forum_topic.errors.to_json, :status => :unprocessable_entity } 
      end
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
