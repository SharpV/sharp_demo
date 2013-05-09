class Group::MediaController < GroupController
  
  set_tab :media, :group_nav

  def index
    @folders = @current_group.folders
    @media = Medium.where(folder_id: @folders.map(&:id)).page params[:page]
  end

  def new
    @folder = Folder.find params[:folder_id]
    @medium = Medium.new
  end


  def create
    @folder = Folder.find params[:folder_id]
    @medium = Medium.new
    @medium.file = params[:files].first
    respond_to do |format|
      @medium.creator = current_user
      @medium.mediumable = @folder
      if @medium.save
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [@medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
  end

end
