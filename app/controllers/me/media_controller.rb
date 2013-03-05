#encoding: utf-8

class Me::MediaController < MeController
  skip_before_filter :verify_authenticity_token

  def index
    @media = current_user.media.page(params[:page])
  end

  def new
    @medium = Medium.new
    session[:media] = nil
  end

  def create
    if params[:qqfile]
      medium = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
      @medium = current_user.media.build file: medium
      if @medium.save
        session[:media] = session[:media] || Array.new
        session[:media] << @medium
        render json: {:success => true, :src => @medium.file.url}
      else
        render json: @medium.errors.to_json
      end
    elsif params[:medium][:folder_id]
      if folder = Folder.find(params[:medium][:folder_id])
        folder.media = session[:media] 
        redirect_to [:me, folder]
      end
    else
      flash[:error] = "请选择正确的上传方式..."
      render action: :new
    end
  end

  def destroy
      @asset = Asset.find(params[:id])
      @asset.destroy
      render :json => true
  end
end
