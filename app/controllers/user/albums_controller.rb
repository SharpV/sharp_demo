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
    render 'shared/albums/edit'
  end

  def create
    @album = Album.new params[:album]
    @album.albumable = current_user
    @album.creator = current_user
    if @album.save
      render 'shared/albums/create'
    end
  end

  def update
    @album = Album.find params[:id]
    if @album.update_attributes params[:album]
      @albums = current_user.albums
      render 'shared/albums/update'
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    render 'shared/albums/destroy'
  end
end
