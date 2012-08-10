class PostCategoriesController < ApplicationController
  respond_to :html, :js
  set_tab :post, :user_menus
  set_tab :home, :site_menus
  include TheSortableTreeController::Rebuild

  def index
    @user = current_user
    @post_category = PostCategory.new
    current_user.init_category!
    @post_categories = current_user.post_categories.nested_set.all
  end

  def edit
    @post_category = PostCategory.find params[:id]
    respond_to do |format|
      format.js
    end
  end

  def manage
    @article_categories = ArticleCategory.nested_set.all
  end

  def new
    @post_category = PostCategory.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @post_category = PostCategory.new(params[:post_category])   
    @post_category.user = current_user 
    @post_category.save
    redirect_to post_categories_path
  end
end
