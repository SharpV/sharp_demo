class Course::SectionsController < CourseController
set_tab :slots, :course_nav

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
  end

  def new
    @section = Section.new course_id: params[:course_id]
  end
end
