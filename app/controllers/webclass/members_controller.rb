class Webclass::MembersController < WebclassController
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :members, :webclass_admin_nav
  def admin
    @members = @current_webclass.members
  end
end
