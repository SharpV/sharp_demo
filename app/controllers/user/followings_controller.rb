class User::FollowingsController < UserController

  respond_to :html, :json

  set_tab :followings, :user_activities_nav
  set_tab :home, :user_nav

  def index
    @followings = current_user.followings.page params[:page]
  end

  def destroy
    @following = Follow.find(params[:id])
    @actor = @following.actor
    @following.destroy if current_user.is_following?(@actor)
  end
end
