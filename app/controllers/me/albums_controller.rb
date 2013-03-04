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
    puts session[:assets].inspect

    @post = current_user.posts.build params[:post_album]
    @post.assets = session[:assets]
    respond_to do |format|
      if @post.save
        format.html { redirect_to me_album_path(@post), notice: '您的相册已成功创建!' }
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
