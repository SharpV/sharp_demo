class Me::DocumentsController < MeController
  # GET /me/documents
  # GET /me/documents.json
  def index
    @posts = Me::Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /me/documents/1
  # GET /me/documents/1.json
  def show
    @post = Post::Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /me/documents/new
  # GET /me/documents/new.json
  def new
    @post = Post::Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /me/documents/1/edit
  def edit
    @post = Post::Document.find(params[:id])
  end

  # POST /me/documents
  # POST /me/documents.json
  def create
    @post = Post::Document.new(params[:post_document])
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

  # PUT /me/documents/1
  # PUT /me/documents/1.json
  def update
    @post = Post::Document.find(params[:id])

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

  # DELETE /me/documents/1
  # DELETE /me/documents/1.json
  def destroy
    @post = Post::Document.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to me_documents_url }
      format.json { head :no_content }
    end
  end
end
