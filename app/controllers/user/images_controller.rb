#encoding: utf-8

class User::ImagesController < UserController
  
  set_tab :images, :user_nav

  def index
    @albums = @current_user.albums
    @images = Image.where imageable_type: 'album', imageable_id: @albums.collect{|a|a.id}
  end

  def new 
    @album = Album.find params[:album_id]
    @image = Image.new
    @albums = @current_user.albums
    @images = Image.where imageable_type: 'album', imageable_id: @albums.collect{|a|a.id}
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
