class Me::AlbumsController < MeController
  def index
    @posts = Post::Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post::Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def new
    @post = Post::Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post::Album.find(params[:id])
  end

  def create
    @post = Post::Album.new(params[:post_document])
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_me_document_path(@post), notice: 'Document was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post::Album.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:me_document])
        format.html { redirect_to @me_document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @me_document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post::Album.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to me_documents_url }
      format.json { head :no_content }
    end
  end
end
