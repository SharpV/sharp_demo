class PostsController < ApplicationController

  set_tab :posts, :site_nav

  
  def index
    if params[:grade_id]
      @posts = Post.share.includes(:creator).where(grade_id: params[:grade_id]).page params[:page]
    elsif params[:subject_id]
      @posts = Post.share.includes(:creator).where(subject_id: params[:subject_id]).page params[:page]
    else
      @posts = Post.share.includes(:creator).page params[:page]
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
  end
  
  def create
    @post = current_user.posts.build params[:post]
    if @post.save
      redirect_to group_post_path(@current_group, @post)
    else
      render :action => :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to group_post_path(@current_group, @post) 
    else
      render :action => :edit
    end
  end

end
