#encoding: utf-8

class User::ImagesController < UserController
  
  set_tab :images, :user_nav

  def index
    @albums = @current_user.albums
    @images = Image.where album_id: @albums.map(&:id)
  end

  def new 
    @image = Image.new
    @albums = @current_user.albums
    @images = Image.where album_id: @albums.map(&:id)
  end


  def create
    @image = Image.new params[:image]
    @image.file = params[:files].first
    respond_to do |format|
      @image.user = current_user
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
