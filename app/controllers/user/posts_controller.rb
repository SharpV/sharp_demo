#encoding: utf-8
class My::PostsController < MyController
  
  before_filter :find_user
    
  set_tab :post, :user_menus, :only => [:index, :show]
  set_tab :create, :user_menus, :only => [:new, :edit]

  def index
    @posts = @user.posts.page(params[:page])
    @post_categories = current_user.post_categories.nested_set.all
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def edit
    @post = Post.find params[:id]
    @user = current_user 
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @post.update_attribute :views_count, @post.views_count+1 unless session[:logged_in]
    @comment = Comment.new
    @comments = @post.comments.nested_set.all
  end

  def create
    @post = Post.new(params[:post])
    @post.tag_list = params[:item][:tag].join(",") if params[:item] and params[:item][:tag]
    @post.user = current_user
    respond_to do |format|
      if @post.save 
        format.html  { redirect_to([@user, @post]) }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  def update
    @user = current_user
    if params[:item] and params[:item][:tag]
      params[:post][:tag_list] = params[:item][:tag]
    end
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html  { redirect_to([@user, @post]) }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  # DELETE /my/posts/1
  # DELETE /my/posts/1.json
  def destroy
    @my_post = Post.find(params[:id])
    @my_post.destroy

    respond_to do |format|
      format.html { redirect_to my_posts_url }
      format.json { head :no_content }
    end
  end
end
