class Course::SectionsController < CourseController
    
  respond_to :html, :js
  
  set_tab :slots, :course_nav 
  set_tab :admin, :course_nav, only: [:admin]
  set_tab :sections, :course_admin_nav

  def index
    @sections = @course.sections
    @slots = @course.slots
    if @sections.count == 0 
      redirect_to new_course_course_section(@course)
    elsif slots.count == 0
      redirect_to admin_course_course_section(@course)
    end
  end

  def admin
    @section = Section.new
    @sections = @course.sections
  end

  def create
    @section = @course.sections.build params[:section]
    if @section.save
      respond_with do |format|
        format.js
      end
    else

    end
  end

  def new
    @section = Section.new course_id: params[:course_id]
  end
end
