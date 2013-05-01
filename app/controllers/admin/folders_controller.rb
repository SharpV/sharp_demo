class Me::FoldersController < MeController

  respond_to :html, :json
  
  set_tab :media, :me_nav
  set_tab :media, :media_nav
  set_tab :folder, :media_nav, only: [:admin]

  def index
    @folders = current_user.folders
    @media = current_user.media
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
    @media = current_user.media
  end

end
