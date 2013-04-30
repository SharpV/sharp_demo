class Group::PostsController < GroupController
  respond_to :html, :js
  set_tab :posts, :group_nav

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag], :on => :tags, :owned_by => @current_group).page params[:page]
    else
      @posts = @current_group.posts.includes(:creator).page params[:page]
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find params[:id]
  end

  def show
    @post = Post.find params[:id]
    @comments = @post.comments.recent.page(params[:page])
  end

  def update
    @post = Post.find params[:id]
    if @post.creator_id == current_user.id and @post.update_attributes params[:post] 
      if @post.tag_list.size > 0
        @current_group.tag_list.add(@post.tag_list) 
        @current_group.save
      end
      redirect_to [@current_namespace, @post].flatten
    else
      render action: :new
    end
  end 

  def create
    tag_list = params[:post].delete(:tag_list)
    @post = Post.new params[:post]
    @post.creator = current_user
    @post.postable = @current_group
    if @post.save
      if tag_list
        @current_group.tag(@post, :with => tag_list, on: :tags) 
        @current_group.save
      end
      redirect_to [@current_namespace, @post].flatten
    else
      render action: :new
    end
  end

  def destroy
    @post = Post.find params[:id]
    if @post.creator_id == current_user.id and @post.destroy
      redirect_to [:webclass, @current_group, :posts]
    else
      redirect_to [:webclass, @current_group, @post]
    end
  end
end
