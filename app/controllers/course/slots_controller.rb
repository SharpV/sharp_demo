class Course::SlotsController < CourseController

  set_tab :slots, :course_admin_nav, only: [:admin]

  set_tab :admin, :course_nav, only: [:admin]


  respond_to :html, :json

  def new
    @section = Section.find params[:section_id]
    @slot = Slot.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @section = Section.find params[:section_id]
    @slot = @section.slots.build params[:slot]
    @slot.course = @course
    @slot.creator = current_user
    if @slot.save
      redirect_to admin_course_course_section_slot_path(@course, @section, @slot)
    end
  end

  def admin
    @slot = Slot.find params[:id]
  end

  def show
    @slot = Slot.find params[:id]
  end
end
