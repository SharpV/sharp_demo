class Me::FoldersController < MeController

  set_tab :media, :me_nav
  set_tab :folder, :media_nav
  
  include TheSortableTreeController::Rebuild

  def manage
    @folders = Folder.nested_set.select('id, name, parent_id').all
  end


  def show
    @folder = Folder.find params[:id]
    @media = @folder.media
  end

end
