class User::FoldersController < UserController

  respond_to :html, :json
  
  set_tab :media, :user_nav

  def index
    @folders = @current_user.folders
    @folder = Folder.new
  end

  def show
    @folder = Folder.find params[:id]
    @media = Medium.where(mediumable_type: Folder.to_s, mediumable_id: @folder.id).page params[:page]
    @folders = @current_user.folders
  end

  def edit
    @folder = Folder.find params[:id]
    render 'shared/folders/edit'
  end

  def update
    @folder = Folder.find params[:id]
    if @folder.update_attributes params[:folder]
      @folders = current_user.folders
      render 'shared/folders/update'
    end
  end

  def destroy
    @folder = Folder.find params[:id]
    if @folder.destroy
      render 'shared/folders/destroy'
    end
  end

  def create
    @folder = current_user.folders.build params[:folder]
    if @folder.save
      render 'shared/folders/create'
    end
  end

end
