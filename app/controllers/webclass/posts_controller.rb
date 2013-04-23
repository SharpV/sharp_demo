class Webclass::PostsController < WebclassController
  respond_to :html, :js
  set_tab :posts, :webclass_nav

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag], :on => :tags, :owned_by => @current_webclass).page params[:page]
    else
      @posts = @current_webclass.posts.includes(:creator).page params[:page]
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
        @current_webclass.tag_list.add(@post.tag_list) 
        @current_webclass.save
      end
      redirect_to [:webclass, @current_webclass, @post]
    else
      render action: :new
    end
  end 

  def create
    tag_list = params[:post].delete(:tag_list)
    @post = Post.new params[:post]
    @post.creator = current_user
    @post.postable = @current_webclass
    if @post.save
      if tag_list
        @current_webclass.tag(@post, :with => tag_list, on: :tags) 
        @current_webclass.save
      end
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
