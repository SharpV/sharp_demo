class Group::ImagesController < GroupController

  set_tab :images, :group_nav

  def index
    @albums = @current_group.albums
    @images = Image.where imageable_type: Album.to_s, imageable_id: @albums.map(&:id)
  end

  def new 
    @album = Album.find params[:album_id]
    @image = Image.new
  end


  def create
    @album = Album.find params[:album_id]
    @image = Image.new
    @image.file = params[:files].first
    respond_to do |format|
      @image.creator = current_user
      @image.imageable = @album
      if @image.save
        format.json { render json: [@image.to_jq_upload].to_json, status: :created, location: [@image] }
      else
        render json: @image.errors.to_json
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end


end
