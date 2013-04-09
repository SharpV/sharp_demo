class Group::PostsController < GroupController

  set_tab :posts, :group_nav

  def index
    @posts = @current_group.posts.page(params[:page])
  end
  
  def new
    @post = Post.new category: Category.find(params[:category_id])
  end

  def create
    @post = @current_group.posts.build(params[:post])
    @post.creator = current_user
    if @post.save
      redirect_to group_group_post_path(@current_group, @post)
    else
      render action: :new
    end
  end

  def show
    @post = Post.find params[:id]
  end
  
end
