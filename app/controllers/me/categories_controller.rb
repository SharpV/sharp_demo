class Me::CategoriesController < MeController
  
  respond_to :html, :json
  
  include TheSortableTreeController::Rebuild
  set_tab :category, :post_nav
  
  def index
    @categories = current_user.post_categories.nested_set.all
  end

  def admin
    @category = Category.new
    @categories = current_user.categories
  end

  def new
    @category = PostCategory.new 
    respond_to do |format|
      format.js
    end
  end

  def edit
    @category = PostCategory.find params[:id]
  end

  def create
    @category = current_user.categories.build(params[:category])
    @category.creator = current_user
    if @category.save
      respond_with do |format|
        format.js
      end
    end
  end

  def update
    @category = PostCategory.find params[:id]
    @category.update_attributes! params[:post_category]
  end
end
