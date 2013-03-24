 # encoding: utf-8

class Me:BookmarksController < MeController
  def index
     @posts = Post::Link.list.page(params[:page])

  	 respond_to do |format|
   	   format.html # index.html.erb
       format.json { render json: @posts }
     end
   end

   def new
  	@post = Post::Link.new
    respond_to do |format|
    	format.html # new.html.erb
  		format.json { render json: @post }
   	end
  end

  def edit
    @post = Post::Link.find(params[:id])
  end

  def create
    @post = Post::Link.new(params[:post_bookmark])
    @post.user = current_user
    #begin
      l = Linkser.parse @post.url
      @post.title = l.title
      @post.body = l.description
      puts @post.inspect
      respond_to do |format|
        if @post.save
          format.html { redirect_to me_links_path, notice: '您的书签已被成功创建 ！' }
          format.json { render json: @post, status: :created, location: @post }
        else
          format.html { render action: "new" }
        end
      end
    #rescue
        #format.html { render action: "new" }
    #end
  end

  def update
    @post = Post::Link.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post_bookmark])
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
    @post = Post::Link.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to me_documents_url }
      format.json { head :no_content }
    end
  end
end
