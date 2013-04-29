#encoding: utf-8

class User::MediaController < UserController

  respond_to :html, :json

  set_tab :media, :user_nav
  
  def index
    @folders = @current_user.folders
    @media = current_user.media.folder.page params[:page]
  end

  def new
    @medium = Medium.new
    @folders = current_user.folders
    @folder = Folder.find params[:folder_id]
  end

  def create
    @folder = Folder.find params[:folder_id]
    @medium = Medium.new
    @medium.file = params[:files].first
    respond_to do |format|
      @medium.mediumable = @folder
      @medium.creator = current_user
      if @medium.save
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [@medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end
end
