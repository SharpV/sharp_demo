class PostsController < ApplicationController

  set_tab :posts, :site_nav

  
  def index
    if params[:column_id]
      @posts = Post.share.includes(:user, :column).where(column_id: params[:column_id]).page params[:page]
    else
      @posts = Post.share.includes(:user, :column).order('comments_count').page params[:page]
    end
    set_tab :index, :posts_nav
  end
  
  def new
    @post = Post.new
  end

  def latest
    @posts = Post.share.includes(:user, :column).order('created_at desc').page params[:page]
    set_tab :latest, :posts_nav
    render template: 'posts/index'
  end
  
  def show
    @post = Post.find params[:id]
  end
  
  def hot
    @posts = Post.share.includes(:user, :column).order('readings_count desc').page params[:page]
    set_tab :hot, :posts_nav
    render template: 'posts/index'
  end

  def top
    @top_users = User.order('posts_value desc').page(params[:page]).per(28) 
    
    set_tab :top, :posts_nav

  end

end
