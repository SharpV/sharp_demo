class Admin::ColumnsController < AdminController
  set_tab :activities, :me_nav
  set_tab :index, :site_nav
  def index
    @my_webclasses = current_user.webclasses
    @my_groups = current_user.groups
  end
end
