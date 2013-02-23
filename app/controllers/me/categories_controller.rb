class Me::CategoriesController < MeController
  
  respond_to :html, :json
  
  include TheSortableTreeController::Rebuild
  set_tab :category, :post_nav
  
  def index
    @categories = current_user.categories.nested_set.all
  end

  def manage
    @categories = current_user.categories.nested_set.all
  end

  def new
    @category = Category.new 
    respond_to do |format|
      format.js
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = current_user.categories.build(params[:category])

    render :action => :new unless @category.save
  end

  def update
    @category = Category.find params[:id]
    @category.update_attributes! params[:category]
  end
end
