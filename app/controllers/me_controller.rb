class MeController < ApplicationController
  before_filter :authenticate_user!

  set_tab :index, :site_nav
  
  layout "me"
  
end
