class Webclass::SlotsController < WebclassController
  respond_to :html, :js
  
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :slots, :webclass_admin_nav
  set_tab :slots, :webclass_nav, only: [:index]
  def index
    @sections = @current_webclass.current_term.sections.order(:start_at)
  end

  def admin
    @terms = @current_webclass.terms
    @slots = @current_webclass.current_term.slots.order(:start_at)
  end


  def create
    @slot = Slot.new params[:slot]
    @slot.webclass = @current_webclass
    @slot.creator = current_user
    @slot.term = @current_webclass.current_term
    unless @slot.save
      nil
    end
  end
end
