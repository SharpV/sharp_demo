 #encoding: utf-8

class Group::CoursesController < GroupController
  respond_to :html, :js
  
  set_tab :admin, :group_nav, only: [:admin]
  set_tab :courses, :group_nav

  def index
    @courses = @current_group.courses
    @sections = @current_group.current_term.sections.order(:start_at)
  end

  def admin
    @sections = @current_group.current_term.sections.order(:start_at)
    @course = Course.new
  end

  def show
    @courses = @current_group.courses
    @course = Course.find params[:id]
    @media = @course.media.page params[:page]
    @medium = Medium.new
    self.try :set_tab, "course_#{@course.id}", :group_courses_nav
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
