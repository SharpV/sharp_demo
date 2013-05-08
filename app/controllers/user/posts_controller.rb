class User::PostsController < UserController

  before_filter :check_owner, except: [:index, :show]

  set_tab :posts, :user_nav
  set_tab :index, :post_nav

	def index
		@posts = current_user.posts
    @categories = @current_user.categories
	end

  def show
    @categories = @current_user.categories
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  # GET /me/notes/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new params[:post]
    @post.user = current_user
    if @post.save
      redirect_to [:user, current_user, @post]
    else
      render action: :new
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [:me, @post], notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /me/notes/1
  # DELETE /me/notes/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end
end