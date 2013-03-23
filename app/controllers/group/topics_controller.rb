class Group::TopicsController < GroupController

  set_tab :topics, :group_nav

  def index
    @topics = @group.group_topics.page(params[:page])
  end
  
  def new
    @topic = GroupTopic.new
  end

  def create
    @topic = @group.group_topics.build params[:group_topic]
    @topic.user = current_user
    if @topic.save
      redirect_to [@group, @topic]
    else
      render action: :new
    end
  end

  def show
    @topic = GroupTopic.find params[:id]
  end
  
end
