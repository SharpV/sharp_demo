class Group::NotificationsController < GroupController
  before_filter :find_user
  set_tab :notification, :user_menus
  before_filter :authenticate_user!
  
  def index
  end
end
