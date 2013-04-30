 #encoding: utf-8

class Group::FoldersController < GroupController
  respond_to :html, :json
  
  set_tab :media, :group_nav

  def index
    @folders = @current_group.folders
    @folder = Folder.new
  end

  def show
    @folders = @current_group.folders
    @folder = Folder.find params[:folder_id]
    @media = Medium.where(mediumable_type: Folder.to_s, mediumable_id: @folder.id).page params[:page]
  end

  def edit
    @folder = Folder.find params[:id]
    render 'shared/folders/edit'
  end

  def update
    @folder = Folder.find params[:id]
    if @folder.update_attributes params[:folder]
      @folders = @current_group.folders
      render template: 'shared/folders/update'
    end
  end

  def destroy
    @folder = Folder.find params[:id]
    if @folder.destroy
    end
  end

  def create
    @folder = Folder.new params[:folder]
    @folder.folderable = @current_group
    @folder.creator = current_user
    if @folder.save
      render 'shared/folders/create'
    end
  end

  def show
    @folder = Folder.find params[:id]
    @media = current_user.media.folder.page params[:page]
    @folders = @current_user.folders
  end
end
