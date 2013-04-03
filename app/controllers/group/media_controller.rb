class Group::MediaController < GroupController
  
  set_tab :media, :group_nav

  skip_before_filter :verify_authenticity_token

  respond_to :html, :json

  def index
    @folder = Folder.find params[:folder_id]
    @media = @folder.media
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media.map{|upload| upload.to_jq_upload } }
    end
  end

  def new
    @folder = Folder.find(params[:folder_id])
    @medium = Medium.new folder: @folder 
  end

  def create
    @folder = Folder.find params[:folder_id]
    @medium = @folder.media.build params[:medium]
    @medium.mediumable = @group
    @medium.folder = @folder
    respond_to do |format|
      @medium.creator = current_user
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
