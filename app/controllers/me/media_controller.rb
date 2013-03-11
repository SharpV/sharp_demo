#encoding: utf-8

class Me::MediaController < MeController
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json
  set_tab :media, :me_nav
  set_tab :media, :media_nav
  
  def index
    #session[:media] = session[:media] || Array.new
    @media = Medium.all#find_all_by_id session[:media]
    puts "......" + @media.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media.map{|upload| upload.to_jq_upload } }
    end
  end

  def new
    @medium = Medium.new
    session[:media] = nil
  end

  def create
    @medium = Medium.new(params[:medium])
    respond_to do |format|
      #medium = params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file]
      @medium.user = current_user
      if @medium.save
        session[:media] = session[:media] || Array.new
        session[:media] << @medium.id
        #render json: {:success => true, :src => @medium.file.url}
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [:me, @medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end

  def destroy
      @asset = Asset.find(params[:id])
      @asset.destroy
      render :json => true
  end
end
