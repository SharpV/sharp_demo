#encoding: utf-8

class Me::MediaController < MeController
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json

  set_tab :media, :me_nav
  set_tab :media, :media_nav
  
  def index
    @folder = Folder.find params[:folder_id]
    @media = @folder.media
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media.map{|upload| upload.to_jq_upload } }
    end
  end

  def new
    @medium = Medium.new
    @folder = Folder.find params[:folder_id]
  end

  def create
    @folder = Folder.find params[:folder_id]
    @medium = @folder.media.build params[:medium]
    respond_to do |format|
      @medium.user = current_user
      if @medium.save
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [:me, @medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
    render :json => true
  end
end
