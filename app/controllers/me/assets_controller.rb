class Me::AssetsController < MeController
  skip_before_filter :verify_authenticity_token
  def index
      @assets = current_user.assets
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @assets.map{|asset| asset.to_jq_upload } }
    end
  end

  def create
    file = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
    #@asset = Asset.new(file: file)
    puts current_user.inspect
    @asset = current_user.assets.build file: file
    if @asset.save
      puts @asset.inspect
      render json: {:success => true, :src => @asset.file.url}
    else
      puts file.inspect
      render json: @asset.errors.to_json
    end
  end

  def destroy
      @asset = Asset.find(params[:id])
      @asset.destroy
      render :json => true
  end
end
