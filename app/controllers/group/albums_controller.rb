class Group::AlbumsController < GroupController

  respond_to :html, :js
  set_tab :images, :group_nav

  def index
    @albums = @current_group.albums
    @album = Album.new
  end

  def show
    @albums = @current_group.albums
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

  def update
    @album = Album.find params[:id]
    if @album.update_attributes params[:album]
      @albums = @current_group.albums
      render 'shared/albums/update'
    end
  end

  def create
    @album = Album.new params[:album]
    @album.albumable = @current_group
    @album.creator = current_user
    if @album.save
      render 'shared/albums/create'
    end
  end

end
