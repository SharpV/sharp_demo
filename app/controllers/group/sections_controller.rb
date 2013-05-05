 #encoding: utf-8

class Group::SectionsController < GroupController
  respond_to :html, :js
  
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :sections, :webclass_admin_nav
  def index
  end

  def index
    @section = Section.new
    @terms = @current_group.terms
    @sections = @current_group.current_term.sections.order(:start_at)
  end

  def edit
    @section = Section.find params[:id]
  end

  def update
    @section = Section.find params[:id]
    @section.update_attributes params[:section]
  end


  def create
    @section = Section.new params[:section]
    @section.group = @current_group
    @section.creator = current_user
    @section.term = @current_group.current_term
    unless @section.save
      nil
    end
  end

  def destroy
    @section = Section.find params[:id]
    @section.destroy
  end
end
