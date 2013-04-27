class User::CategoriesController < UserController
  
  respond_to :html, :json
  
  set_tab :posts, :user_nav
  
  def index
    @category = Category.new 
    @categories = current_user.categories
  end

  def show
    @category = Category.find params[:id]
    @posts = @category.posts.page params[:page]
    @categories = @category.categoryable.categories
    render template: 'user/posts/index'
  end

  def new
    @category = Category.new 
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.new(params[:category])
    @category.creator = current_user
    @category.categoryable = current_user
    if @category.save
    end
  end

  def update
    @category = Category.find params[:id]
    @category.update_attributes! params[:category]
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy

    end
  end
end
