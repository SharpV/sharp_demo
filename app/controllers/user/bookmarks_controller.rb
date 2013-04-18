 #encoding: utf-8

class Me::BookmarksController < MeController
  respond_to :html, :json
  
  def index
     @bookmarks = current_user.bookmarks.page(params[:page])

  	 respond_to do |format|
   	   format.html # index.html.erb
       format.json { render json: @bookmarks }
     end
   end

   def new
  	@bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find params[:id]
  end

  def create
    @bookmark = current_user.bookmarks.build params[:bookmark]
    begin
      l = Linkser.parse @bookmark.origin_url
    rescue
      render action: :new
    end
    @bookmark.title = l.title
    @bookmark.body = l.description
    if @bookmark.save
      redirect_to edit_me_bookmark_path(@bookmark)
    else
      render action: :new
    end
  end

  def update
    @bookmark = Bookmark.find params[:id]
    if @bookmark.update_attributes(params[:bookmark])
      redirect_to me_bookmarks_path
    else
      render action: :edit
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
