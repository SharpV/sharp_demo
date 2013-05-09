class Group::ImagesController < GroupController

  set_tab :images, :group_nav

  def index
    @albums = @current_group.albums
    @images = Image.where(album_id: @albums.map(&:id)).page params[:page]
  end

  def new 
    @albums = @current_group.albums
    @image = Image.new
  end


  def create
    @image = Image.new params[:image]
    @image.file = params[:files].first
    respond_to do |format|
      @image.user = current_user
      @image.group = @current_group
      if @current_group.has_album?(@image.album_id) and @image.save
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
