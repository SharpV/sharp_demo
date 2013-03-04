class Me::PostCategoriesController < MeController
  
  respond_to :html, :json
  
  include TheSortableTreeController::Rebuild
  set_tab :category, :post_nav
  
  def index
    @categories = current_user.post_categories.nested_set.all
  end

  def manage
    @categories = current_user.post_categories.nested_set.all
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
    @category = current_user.post_categories.build(params[:post_category])

    render :action => :new unless @category.save
  end

  def update
    @category = PostCategory.find params[:id]
    @category.update_attributes! params[:post_category]
  end
end
