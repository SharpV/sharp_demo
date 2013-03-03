class PostsController < ApplicationController
  #before_filter :set_group_tab
  set_tab :post, :group_menus
  set_tab :post, :group_actions, :only => %w(new edit)

  
  def index
    @posts = Post.share.page params[:page]
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
