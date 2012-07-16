class PostsController < ApplicationController

  set_tab :post, :site_menus
  
  def index
    @tags = Post.tag_counts_on(:tags)
    @posts = Post.order("created_at desc").page(params[:page])
    respond_to do |format|
      format.html
      format.atom { render :layout => false }
    end
  end
  
  def show
    @tags = Post.tag_counts_on(:tags)
    @posts = Post.tagged_with(params[:tag]).order("created_at desc").page(params[:page])
  end

  def load_url
    @link = Linkser::parse(params[:url])
    respond_to do |format|
      format.js {render :content_type => 'text/javascript', :locals => { :link => @link}}
    end
  end

end
