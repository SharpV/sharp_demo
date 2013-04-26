class User::FollowersController < UserController
  respond_to :html, :json

  set_tab :followers, :user_activities_nav
  set_tab :home, :user_nav

  def index
    @followers = current_user.followers.page params[:page]
  end

  def destroy
    @following = Follow.find(params[:id])
    @follower = @following.follower
    @following.destroy if current_user.is_followed?(@follower)
  end
end
