class Webclass::CoursesController < WebclassController
  respond_to :html, :js
  
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :slots, :webclass_admin_nav

  def index
  end

  def admin
    @sections = @current_webclass.current_term.sections
    @slot = Slot.new
  end

  def create
    course_name = params[:slot].delete :name
    if course_name
      @course = @current_term.get_course(course_name)
      @slot = Slot.new params[:slot]
      @slot.course = @course
      @slot.term = @current_term
      @slot.save 
    end
  end
end
