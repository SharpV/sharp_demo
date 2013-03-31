class Group::CategoriesController < GroupController
  set_tab :topic, :group_nav, only: [:show]

  set_tab :category, :setting_nav, only: [:admin]
  set_tab :admin, :group_nav, only: [:admin]

  respond_to :html, :json

  def admin
    @categories = @group.categories
    @category = Category.new categoryable: @group
  end

  def show

  end

  def edit
    @category = PostCategory.find params[:id]
  end

  def create
    @category = @group.categories.build(params[:category])
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
