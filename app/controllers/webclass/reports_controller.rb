 #encoding: utf-8

class Webclass::ReportsController < WebclassController

  respond_to :html, :js
  set_tab :reports, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  
  def index

  end
end
