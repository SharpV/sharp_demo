class Group::AlbumsController < GroupController

  respond_to :html, :js
  set_tab :albums, :group_nav

  def index
    @albums = @current_group.albums
    @images = Image.where imageable_type: 'album', imageable_id: @albums.collect{|a|a.id}
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
  end

  def create
    @album = Album.new params[:album]
    @album.albumable = @current_group
    @album.creator = current_user
    if @album.save
      redirect_to [:webclass, @current_group, @album]
    end
  end

end
