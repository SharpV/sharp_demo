class Webclass::ImagesController < WebclassController
  set_tab :albums, :webclass_nav

  def index
    @albums = @current_webclass.albums
    @album = Album.find params[:album_id]
    @image = Image.new
    self.try :set_tab, "album_#{@album.id}", :webclass_courses_nav
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
