class Me::PhotosController < MeController
  set_tab :photo, :setting_nav
  set_tab :settings, :me_nav

  def index
    
  end

  def show

  end

  def new
    
  end

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to me_settings_url
    else
      render action: :index
    end
  end

  def destroy

  end
end
