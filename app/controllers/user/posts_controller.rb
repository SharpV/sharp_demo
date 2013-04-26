class User::PostsController < UserController
  set_tab :posts, :me_nav
  set_tab :index, :post_nav

	def index
		@posts = current_user.posts
    @categories = current_user.categories
	end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  # GET /me/notes/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /me/notes
  # POST /me/notes.json
  def create
    @post = Post.new params[:post]
    @post.creator = current_user
    @post.postable = current_user
    if @post.save
      redirect_to [:user, current_user, @post]
    else
      render action: :new
    end
  end

  # PUT /me/notes/1
  # PUT /me/notes/1.json
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

    respond_to do |format|
      format.html { redirect_to me_notes_url }
      format.json { head :no_content }
    end
  end
end