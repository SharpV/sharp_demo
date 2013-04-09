class Group::FoldersController < GroupController
  set_tab :folders, :group_nav, only: [:index, :show]

  set_tab :folder, :setting_nav, only: [:admin]

  set_tab :admin, :group_nav, only: [:admin]

  respond_to :html, :json

  def index
    @media = @current_group.media
  end

  def admin
    @folders = @current_group.folders
    @folder = Folder.new folderable: @current_group
  end

  def create
    @folder = @current_group.folders.build params[:folder]
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