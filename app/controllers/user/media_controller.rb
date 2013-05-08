#encoding: utf-8

class User::MediaController < UserController

  respond_to :html, :json

  before_filter :check_owner, except: [:index]

  set_tab :media, :user_nav
  
  def index
    @folders = @current_user.folders
    @media = @current_user.media.not_group.page params[:page]
  end

  def new
    @medium = Medium.new
    @folders = current_user.folders
  end

  def create
    @medium = Medium.new params[:medium]
    @medium.file = params[:files].first
    respond_to do |format|
      @medium.user = current_user
      if @medium.save
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [@medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end
end
