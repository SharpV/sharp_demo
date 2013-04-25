 #encoding: utf-8

class Group::SlotsController < GroupController
  respond_to :html, :js
  
  #set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :slots, :webclass_nav
  set_tab :slots, :webclass_nav, only: [:index]
  

  def admin
    @terms = @current_group.terms
    @slots = @current_group.current_term.slots.order(:start_at)
  end


  def create
    @slot = Slot.new params[:slot]
    @slot.group = @current_group
    @slot.creator = current_user
    @slot.term = @current_group.current_term
    unless @slot.save
      nil
    end
  end
end
