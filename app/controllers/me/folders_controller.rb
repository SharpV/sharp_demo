class Me::FoldersController < MeController


  def show
    @folder = Folder.find params[:id]
  end

end
