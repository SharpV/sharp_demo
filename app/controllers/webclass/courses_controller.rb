 #encoding: utf-8

class Webclass::CoursesController < WebclassController
  respond_to :html, :js
  
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :courses, :webclass_admin_nav

  def index
  end

  def admin
    @sections = @current_webclass.current_term.sections.order(:start_at)
    @course = Course.new
  end

  def create
    @slots = []
    week = params[:course].delete :week
    @course = @current_term.get_course params[:course].delete :name
    params[:course][:section_ids].each do |section_id|
      @slots << Slot.create(course_id: @course.id, section_id: section_id, week: week, term_id:  @current_term.id)
    end
  end
end
