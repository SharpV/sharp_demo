class PostsController < ApplicationController

  respond_to :html, :js  
  
  layout false
  
  def create 
    @post = current_user.posts.build params[:post] 
    respond_with do |format|
      format.js {}
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
