 #encoding: utf-8

class Group::ReportsController < GroupController

  respond_to :html, :js
  set_tab :reports, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  
  def index

  end
end
