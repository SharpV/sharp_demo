class My::AvatarsController < MyController
  set_tab :avatar, :profile
  
  def index
    @user = current_user
  end
  
  def update
    @user = current_user
    unless User.valid_attribute?('avatar', params[:user][:avatar])
      @user.update_attribute('avatar', params[:user][:avatar])
      redirect_to user_avatars_path(@user)
    else
      render :action => :edit
    end
  end
end
