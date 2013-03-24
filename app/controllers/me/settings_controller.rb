class Me::SettingsController < MeController
  set_tab :basic, :setting_nav
  def index

  end

  def update
    if current_user.update_attributes params[:user]
      redirect_to [:me, 'settings']
    else
      render action: :index
    end
  end
end
