class Me::CoursesController < MeController
  set_tab :courses, :me_nav
  set_tab :index, :course_nav
  
  def index
    @courses = current_user.courses.page params[:page]
  end 

  def new
    @course = Course.new
  end

  def create 
    @course = Course.new params[:course]
    @course.admin = current_user
    if @course.save
      redirect_to admin_course_course_sections_path(@course)
    else
      render action: :new
    end
  end

  def manage
    @courses = Course.where(creator_id: current_user.id)
  end
end
