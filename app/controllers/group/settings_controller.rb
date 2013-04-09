class Group::SettingsController < GroupController


  set_tab :index, :setting_nav
  
  def admin

  end

  def update
    if @current_group.update_attributes params[:group]
      redirect_to @current_group  
    else  
      render :controller => "group/settings", :action => :index
    end
  end
end