class User::FoldersController < UserController

  respond_to :html, :json
  
  set_tab :media, :user_nav

  def index
    @folders = @current_user.folders
    @folder = Folder.new
  end

  def admin
    @folders = current_user.folders
  end

  def edit
    @folder = Folder.find params[:id]
  end

  def update
    @folder = Folder.find params[:id]
    if @folder.update_attributes params[:folder]
      @folders = current_user.folders
    end
  end

  def destroy
    @folder = Folder.find params[:id]
    if @folder.destroy
    end
  end

  def create
    @folder = current_user.folders.build params[:folder]
    if @folder.save
      respond_with do |format|
        format.js
      end
    end
  end

  def show
    @folder = Folder.find params[:id]
    @media = current_user.media.folder.page params[:page]
    @folders = @current_user.folders
  end

end
