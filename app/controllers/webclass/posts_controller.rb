class Webclass::PostsController < WebclassController
  respond_to :html, :js
  set_tab :posts, :webclass_nav

  def index
    @posts = @current_webclass.posts.page params[:page]

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
      redirect_to [:webclass, @current_webclass, @post]
    else
      render action: :new
    end
  end 

  def create
    @post = Post.new params[:post]
    @post.creator = current_user
    @post.postable = @current_webclass
    if @post.save
      redirect_to [:webclass, @current_webclass, @post]
    else
      render action: :new
    end
  end

  def destroy
    @post = Post.find params[:id]
    if @post.creator_id == current_user.id and @post.destroy
      redirect_to [:webclass, @current_webclass, :posts]
    else
      redirect_to [:webclass, @current_webclass, @post]
    end
  end
end
