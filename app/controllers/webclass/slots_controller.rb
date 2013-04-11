class Webclass::SlotsController < WebclassController
  set_tab :slots, :webclass_nav
  def index
  end

  def admin
    @terms = @current_webclass.terms
  end
end
