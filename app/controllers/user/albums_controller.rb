class User::AlbumsController < UserController

  respond_to :html, :js
  set_tab :albums, :user_nav

  def index
    @albums = @current_user.albums
    @images = Image.where imageable_type: 'album', imageable_id: @albums.collect{|a|a.id}
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
      redirect_to [:user, current_user, @album]
    end
  end

  def update
    @album = Album.find params[:id]
    if @album.update_attributes params[:album]
      redirect_to [:user, current_user, @album]
    end
  end
end
