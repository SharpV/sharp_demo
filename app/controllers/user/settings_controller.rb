class User::SettingsController < UserController
  set_tab :settings, :user_nav
  set_tab :basic, :setting_nav
  def index

  end

  def update
    if current_user.update_attributes params[:user]
      redirect_to [@current_namespace, :settings].flatten
    else
      render action: :index
    end
  end
end
