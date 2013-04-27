class User::FoldersController < UserController

  respond_to :html, :json
  
  set_tab :folders, :user_nav

  def index
    @folders = @current_user.folders
    @media = current_user.media.page params[:page]
  end

  def admin
    @folders = current_user.folders
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
    @media = current_user.media.page params[:page]
    @folders = @current_user.folders
  end

end
