class My::ProfilesController < MyController
  set_tab :profile, :user_profiles
  set_tab :profile, :user_menus
  
  def index
    @user = current_user
  end
end
