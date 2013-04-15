 #encoding: utf-8

class Webclass::SettingsController < WebclassController
  set_tab :index, :setting_nav
  set_tab :admin, :webclass_nav

  def admin

  end

  def update
    @current_group = Group.find params[:id]
    if @current_group.update_attributes params[:group]
      redirect_to @current_group  
    else  
      render :controller => "group/settings", :action => :index
    end
  end
end
