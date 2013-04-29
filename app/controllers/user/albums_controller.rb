class User::AlbumsController < UserController

  respond_to :html, :js
  set_tab :images, :user_nav

  def index
    @albums = @current_user.albums
    @album = Album.new
  end

  def show
    @albums = @current_user.albums
    @album = Album.find params[:id]
    @images = @album.images
  end

  def new
    @album = Album.new
  end

  def edit
    @album = Album.find params[:id]
  end

  def create
    @album = Album.new params[:album]
    @album.albumable = current_user
    @album.creator = current_user
    if @album.save
    end
  end

  def update
    @album = Album.find params[:id]
    if @album.update_attributes params[:album]
      @albums = current_user.albums
    end
  end
end
